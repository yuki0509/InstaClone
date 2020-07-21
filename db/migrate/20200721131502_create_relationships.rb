class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      # follow_idの参照先のテーブルは、usesrテーブルにしたいのでto_tableオプションをつける。
      t.references :follow, foreign_key: { to_table: :users }

      t.timestamps

      # user_idとfollow_idをセットでユニーク制約をかける。あるユーザーが同じユーザーを何度もフォローすることを防ぐ。
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
