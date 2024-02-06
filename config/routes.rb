Rails.application.routes.draw do
  namespace :admin do
    get 'members/index'
    get 'members/show'
    get 'members/edit'
  end
  namespace :admin do
    get 'ramen_noodles/index'
    get 'ramen_noodles/show'
    get 'ramen_noodles/edit'
  end
  namespace :admin do
    get 'homes/top'
  end
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "member/registrations",
    sessions: 'member/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
