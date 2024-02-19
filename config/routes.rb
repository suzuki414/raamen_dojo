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
    get "members/my_page" => "members#my_page", as: "my_page"
    get "members/information/edit" => "members#edit", as: "edit_information"
    patch "members/information" => "members#update", as: "update_information"
    get "members/unsubscribe" => "members#unsubscribe", as: "unsubscribe"
    patch "members/withdraw" => "members#withdraw", as: "withdraw"
    get "members/complete" => "members#complete", as: "complete"
    get "/search" => "searches#search", as: "search"
    resources :members, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
        get "follow" => "relationships#follow", as: "follow"
      # 	get "followings" => "relationships#followings", as: "followings"
      # 	get "followers" => "relationships#followers", as: "followers"
    end
    resources :ramen_noodles, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :ramen_noodle_comments, only: [:create, :destroy]
    end
  end

  namespace :admin do
    root to: "ramen_noodles#index"
    get "admin/search" => "searches#search", as: "search"
    resources :members, only: [:index, :show, :edit, :update]
    resources :ramen_noodles, only: [:index, :show, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
