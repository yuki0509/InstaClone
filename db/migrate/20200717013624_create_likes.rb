class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    #中間テーブル作成user_idとpost_idの組み合わせをレコードとして保存。
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
