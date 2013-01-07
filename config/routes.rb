Up22::Application.routes.draw do

  WepayRails.routes(self)

  resources :transactions

  resources :gifts

  resources :authentications

  resources :campaigns


  authenticated :user do
    root :to => 'home#index'
  end


  root :to => "home#index"
  devise_for :users
  resources :users  do
    member do
      get :funding, :funders
    end
  end

  match '/start', to: 'home#start'
  match '/auth/:provider/callback' => 'authentications#create'
  match '/campaigns/:campaign_id/gifts' => 'gifts#new'
  match '/users/:user_id/transaction' => 'transaction#new'
  match 'create_wepay_account', :to => 'users#create_wepay_account'
  match 'wepay_connect', :to => 'users#wepay_connect'
  match 'wepay_auth', :to => 'users#wepay_auth'
  match 'activate', :to => 'campaigns#activate'
  match 'deactivate', :to => 'campaigns#deactivate'
  match 'confirm', :to => 'transactions#confirmation'
end