class Produto < ApplicationRecord
  has_many :movimentacaos

  validates :nome, presence: true
  validates :nome, length: { maximum: 20 }
end
