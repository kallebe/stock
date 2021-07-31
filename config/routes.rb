Rails.application.routes.draw do
  root to: 'movimentacaos#index'
  post 'movimentacaos/', to: 'movimentacaos#create', as: :create_movimentacao
end
