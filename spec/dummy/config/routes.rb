Rails.application.routes.draw do
  mount Docomo::Engine => "/docs"
  mount Jasminerice::Engine => '/jasmine'

  match '*page' => 'pages#show'
  root :to => 'pages#index'
end
