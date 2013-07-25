Rails.application.routes.draw do
  mount Docomo::Engine => "/docs"

  get '*page' => 'pages#show'
  root :to => 'pages#index'
end
