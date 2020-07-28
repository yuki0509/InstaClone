class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      # フォローしている人のID
      t.integer :follower_id, null: false
      # フォロワーのID
      t.integer :followed_id, null: false

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # follower_idとfollowed_idをセットでユニーク制約をかける。あるユーザーが同じユーザーを何度もフォローすることを防ぐ。
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
