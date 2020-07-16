class CreateComments < ActiveRecord::Migration[5.2]
  def change
    #commntsテーブルはusersテーブルとpostsテーブルの中間テーブルの役割
    create_table :comments do |t|
      t.string :body, null: false
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.timestamps
    end
  end
end
