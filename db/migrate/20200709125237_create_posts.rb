class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :body
      #自動でuser_idカラムが追加される。インデックスも追加される。foreing_keyオプションで外部キーが追加される。
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
