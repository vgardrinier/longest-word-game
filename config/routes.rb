Rails.application.routes.draw do
  get 'new' => "games#new"

  post 'score' => "games#score"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
