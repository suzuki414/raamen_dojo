Rails.application.routes.draw do

  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :member do
    post "members/guest_sign_in" => "members/sessions#guest_sign_in"
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get "home/about" => "homes#about", as: "about"
    get "/search" => "searches#search", as: "search"
    resources :members, only: [:index, :show, :edit] do
      collection do
        get "members/my_page" => "members#my_page", as: "my_page"
        get "members/unsubscribe" => "members#unsubscribe", as: "unsubscribe"
        patch "members/withdraw" => "members#withdraw", as: "withdraw"
        get "members/account_closed" => "members#account_closed", as: "account_closed"
        get "members/complete" => "members#complete", as: "complete"
      end  
      resource :relationships, only: [:create, :destroy]
      get "follow" => "relationships#follow", as: "follow"
    end
    resources :ramen_noodles, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :ramen_noodle_comments, only: [:create, :destroy]
    end
    post "ramen_noodle/tag" => "ramen_noodles#get_tag"
  end

  namespace :admin do
    root to: "ramen_noodles#index"
    get "/search" => "searches#search", as: "search"
    resources :members, only: [:index, :show, :edit, :update] do
      get "follow" => "relationships#follow", as: "follow"
    end  
    resources :ramen_noodles, only: [:index, :show, :destroy] do
      resources :ramen_noodle_comments, only: [:destroy]
    end  
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
