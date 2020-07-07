class AddImagesToPosts < ActiveRecord::Migration[5.2]
  def change
    #画像のパスを保存するカラムを追加。DBがMySQLの時はjson型を指定する。
    add_column :posts, :images, :json
  end
end
