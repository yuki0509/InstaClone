# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                      root GET    /                                                                                        posts#index
#                     login GET    /login(.:format)                                                                         sessions#new
#                           POST   /login(.:format)                                                                         sessions#create
#                    logout DELETE /logout(.:format)                                                                        sessions#destroy
#                     users GET    /users(.:format)                                                                         users#index
#                           POST   /users(.:format)                                                                         users#create
#                  new_user GET    /users/new(.:format)                                                                     users#new
#                      user GET    /users/:id(.:format)                                                                     users#show
#             post_comments POST   /posts/:post_id/comments(.:format)                                                       comments#create
#              edit_comment GET    /comments/:id/edit(.:format)                                                             comments#edit
#                   comment PATCH  /comments/:id(.:format)                                                                  comments#update
#                           PUT    /comments/:id(.:format)                                                                  comments#update
#                           DELETE /comments/:id(.:format)                                                                  comments#destroy
#              search_posts GET    /posts/search(.:format)                                                                  posts#search
#                     posts GET    /posts(.:format)                                                                         posts#index
#                           POST   /posts(.:format)                                                                         posts#create
#                  new_post GET    /posts/new(.:format)                                                                     posts#new
#                 edit_post GET    /posts/:id/edit(.:format)                                                                posts#edit
#                      post GET    /posts/:id(.:format)                                                                     posts#show
#                           PATCH  /posts/:id(.:format)                                                                     posts#update
#                           PUT    /posts/:id(.:format)                                                                     posts#update
#                           DELETE /posts/:id(.:format)                                                                     posts#destroy
#       edit_mypage_account GET    /mypage/account/edit(.:format)                                                           mypage/accounts#edit
#            mypage_account PATCH  /mypage/account(.:format)                                                                mypage/accounts#update
#                           PUT    /mypage/account(.:format)                                                                mypage/accounts#update
#         mypage_activities GET    /mypage/activities(.:format)                                                             mypage/activities#index
#                     likes POST   /likes(.:format)                                                                         likes#create
#                      like DELETE /likes/:id(.:format)                                                                     likes#destroy
#             relationships POST   /relationships(.:format)                                                                 relationships#create
#              relationship DELETE /relationships/:id(.:format)                                                             relationships#destroy
#             read_activity PATCH  /activities/:id/read(.:format)                                                           activities#read
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

# annotateで作成された
Rails.application.routes.draw do
  require 'sidekiq/web'
  # letter_openerを使用した画面の表示のために必要。localhost:3000/letter_openerでメールを確認することができる
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
    # localhost:3000/sidekiqでダッシュボードに繋がる
    mount Sidekiq::Web, at: '/sidekiq'
  end

  root to: 'posts#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: %i[index new create show]
  # shallowオプション。show,edit,update,destroyのようにposts/:post_id/comments/:idを使うアクションのURLをcomments/:idという風に短くする。
  resources :posts, shallow: true do
    resources :comments, only: %i[create edit update destroy]
    # /posts/でurlを始めたい場合にcollectionオプションを使う。/posts/:id/でurlを始めたい場合は、memberオプションを使う。
    collection do
      get 'search'
    end
  end

  # namespaceはurlのパスとディレクトリ構成を変更する。マイページにいろいろ追加するので、マイページ用のディレクトリとurlを作る。
  namespace :mypage do
    # ログインユーザーにとってアカウント編集ページは一つしかないので、単一のresourceを使う。index用のルーティングは存在しない。
    resource :account, only: %i[edit update]
    resources :activities, only: %i[index]
  end

  resources :likes, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]

  # urlをactivities/:id/readのみに限定するため、onlyで絞る。
  resources :activities, only: [] do
    # memberオプションでactivities/:idというurlが生成される。この場合は、activitiesコントローラーのreadアクションにリクエストを送る。一つしかない場合は、このような書き方ができる。
    patch :read, on: :member
  end
end
