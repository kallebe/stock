# frozen_string_literal: true

# MovimentacaosHelper
module MovimentacaosHelper
  def products_in_stock(storage)
    products = Produto.joins(:local_armazenamentos).where(local_armazenamentos: storage).uniq

    movimentacoes = Movimentacao.where(local_armazenamento: storage)
    products_quantity = []

    products.each do |product|
      entries = movimentacoes.where(produto: product, tipo: 'E').sum(:quantidade)
      exits   = movimentacoes.where(produto: product, tipo: 'S').sum(:quantidade)

      # Products still in stock
      products_quantity << { nome: product.nome, quantidade: (entries - exits) }
    end

    products_quantity
  end
end
