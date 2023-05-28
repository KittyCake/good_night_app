Rails.application.routes.draw do
  resources :sleep_records, only: [:index, :create] do
    collection do
      get 'followings_records'
    end
  end

  resources :follows, only: [:create] do
    collection do
      delete 'destroy_by_user_ids'
    end
  end
end
