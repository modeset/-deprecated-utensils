Rails.application.routes.draw do
  mount Docomo::Engine => "/docs"
  mount Teabag::Engine => '/teabag'

  match '*page' => 'pages#show'
  root :to => 'pages#index'
end
