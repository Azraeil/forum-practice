Rails.application.routes.draw do
  devise_for :users
  ## 前台路由
  # root
  root "posts#index"

  # 使用者
  resources :users, only: [:edit, :update, :show] do

  end

  # 文章
  resources :posts

  # posts#index 的文章分類按鈕
  resources :categories, only: [:show]

  # 好友關係

  ## 後台路由
  # 進入後台必須有管理員 (admin) 權限
  namespace :admin do
    # GET /admin/users  後台可以瀏覽所有使用者清單
    # POST  /admin/:id/user   可以更新使用者的身份
    resources :users, only: [:index, :update]
    # 後台可以 CRUD `文章的分類` (但不能刪除已經有被使用的分類)
    resources :categories
  end

  # API路由
end
