class MovimentacaosController < ApplicationController
  require 'csv'

  def index
    @movimentacoes = Movimentacao.all
  end

  def create
    @error_messages = []
    order_csv
    create_from_csv
  end

  private

  def order_csv
    # TODO: validate file's presence
    @csv_data = CSV.parse(File.read(params[:movimentacao_csv], headers: true))
    @csv_data = @csv_data.sort { |a, b| a[1].to_date <=> b[1].to_date } # Sort CSV by its date
  end

  def create_from_csv
    @csv_data.each do |row|
      # TODO: validate whether the row has 5 fields
      # TODO: check for validation errors
      storage = LocalArmazenamento.find_by(nome: row[0]) || LocalArmazenamento.create(nome: row[0])
      product = Produto.find_by(nome: row[3]) || Produto.create(nome: row[3])

      movement = Movimentacao.create(
        produto: product,
        local_armazenamento: storage,
        data: row[1].to_date,
        tipo: row[2],
        quantidade: row[4]
      )
    end
  end
end
