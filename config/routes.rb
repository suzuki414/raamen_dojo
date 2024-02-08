Rails.application.routes.draw do
  
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    root to: 'homes#top'
    get 'home/about' => 'homes#about', as: 'about'
    get 'members/my_page' => 'members#my_page', as: 'my_page'
    get 'members/information/edit' => 'members#edit', as: 'edit_information'
    patch 'members/information' => 'members#update', as: 'update_information'
    get 'members/unsubscribe' => 'members#unsubscribe', as: 'unsubscribe'
    patch 'members/withdraw' => 'members#withdraw', as: 'withdraw'
    get 'members/complete' => 'members#complete', as: 'complete'
    resources :members, only: [:index, :show, :edit, :update]
    resources :ramen_noodles, only: [:new, :index, :show, :edit, :create, :update, :destroy]
  end
  
  namespace :admin do
    root to: 'homes#top'
    resources :members, only: [:index, :show, :edit, :update]
    resources :ramen_noodles, only: [:index, :show, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
