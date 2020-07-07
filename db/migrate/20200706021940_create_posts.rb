class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :body, null: false
      #外部キーにはreference型を使う。foreign_key: trueオプションをつけることで外部キー制約が追加される
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
