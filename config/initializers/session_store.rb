InstaClone::Application.config.session_store :redis_store, {
  servers: [
    {
      host: 'localhost', # サーバー名
      port: 6379, # ポート番号
      db: 0, # データベース名(0~15まである。)
      namespace: 'session' # (session:セッション情報)と表示される
    }
  ],
  expire_after: 1.day
}
