Rails.application.routes.draw do
  mount Docomo::Engine => "/docs"

  match '*page' => 'pages#show'
  root :to => 'pages#index'
end
