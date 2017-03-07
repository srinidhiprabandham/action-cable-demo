Rails.application.routes.draw do
  root 'boards#index'
  get 'boards/index'

  mount ActionCable.server => '/cable'
end
