Rails.application.routes.draw do
  
  root to: 'public/homes#top'

  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :public do
    get "home/about" => "homes#about"
    get "home/index" => "homes#index"
    resources :customers,only:[:show, :edit, :update]do
      resource :relationships, only: [:create, :destroy]
      member do
          get :favorites
        end
      collection do
        get 'search'
      end
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :posts,only:[:new, :index, :show, :edit, :create, :destroy, :update]do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only:[:create, :destroy]
      collection do
        get 'search'
      end
    end
    resources :hashtags, only: [:index, :show]
  end
  
  namespace :admin do
    resources :customers, only:[:index, :show, :destroy]
    resources :posts, only:[:index, :show, :destroy]
  end

end
