class Movimentacao < ApplicationRecord
  belongs_to :produto
  belongs_to :local_armazenamento

  validates :tipo, presence: true
  validates :tipo, length: { maximum: 1 }
  validates :data, presence: true
  validates :quantidade, presence: true

  validate :date_must_be_within_interval,
           :allowed_type_values,
           :available_stock

  def date_must_be_within_interval
    minimum_allowed_date = Date.new(2021, 1, 1)
    maximum_allowed_date = Date.new(2021, 1, 31)

    return if data >= minimum_allowed_date && data <= maximum_allowed_date

    errors.add :data, 'Apenas movimentações entre 01/01/2021 e 31/01/2021 são válidas.'
  end

  def allowed_type_values
    return if tipo == 'E' || tipo == 'S'

    errors.add :tipo, 'O tipo de movimentação informado é inválido'
  end

  def available_stock
    return unless tipo == 'S' && quantidade > products_in_stock

    errors.add :quantidade, 'A quantidade informada é superior a quantidade em estoque'
  end

  private

  def products_in_stock
    entries = Movimentacao.where(produto: produto, local_armazenamento: local_armazenamento, tipo: 'E')
                          .where('data <= ?', data)
                          .sum(:quantidade)
    exits   = Movimentacao.where(produto: produto, local_armazenamento: local_armazenamento, tipo: 'S')
                          .where('data <= ?', data)
                          .sum(:quantidade)

    # Products still in stock
    entries - exits
  end
end
