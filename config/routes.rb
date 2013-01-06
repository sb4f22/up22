Up22::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :campaigns
  resources :gifts

match 'activate', :to => 'campaigns#activate'
match 'deactivate', :to => 'campaigns#deactivate'
match '/start', to: 'home#start'
match '/campaigns/:campaign_id/gifts' => 'gifts#new'
end