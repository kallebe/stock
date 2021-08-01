# frozen_string_literal: true

# MovimentacaosController
class MovimentacaosController < ApplicationController
  require 'csv'

  def index
    @storages = LocalArmazenamento.all
  end

  def create
    @error_messages = []

    order_csv
    create_from_csv
  end

  private

  def order_csv
    @csv_data = CSV.parse(File.read(params[:movimentacao_csv], headers: true))

    # Sort CSV by its date and then sorting Entries first
    @csv_data = @csv_data.sort { |a, b| [a[1].to_date, a[2]] <=> [b[1].to_date, b[2]] }
  end

  def create_from_csv
    @csv_data.each do |row|
      @error_messages << 'Cada linha do CSV deve conter 5 colunas de dados.' unless row.length == 5

      storage = create_local_armazenamento row[0]
      next unless storage.valid?

      product = create_produto row[3]
      next unless product.valid?

      create_movimentacao product, storage, row[1], row[2], row[4]
    end
  end

  def create_local_armazenamento(nome)
    storage = LocalArmazenamento.find_by(nome: nome)

    # Create Storage if it doesn't exist
    storage ||= LocalArmazenamento.create(nome: nome)
    @error_messages += storage.errors.full_messages unless storage.valid?

    storage
  end

  def create_produto(nome)
    product = Produto.find_by(nome: nome)

    # Create Product if it doesn't exist
    product ||= Produto.create(nome: nome)
    @error_messages += product.errors.full_messages unless product.valid?

    product
  end

  def create_movimentacao(product, storage, date, type, amount)
    movement = Movimentacao.create(
      produto: product,
      local_armazenamento: storage,
      data: date,
      tipo: type,
      quantidade: amount
    )
    @error_messages += movement.errors.full_messages unless movement.valid?

    movement
  end
end
