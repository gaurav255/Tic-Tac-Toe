Rails.application.routes.draw do
  root 'games#show'
  post 'play', to: 'games#play'
  post 'reset', to: 'games#reset'
  post 'setup', to: 'games#setup'
  post 'end_turn', to: 'games#end_turn'
  # resources :games, only: [:show]
end
