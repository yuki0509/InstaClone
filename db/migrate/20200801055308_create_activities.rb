class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      # ポリモーフィック関連。
      t.references :subject, polymorphic: true
      t.references :user, foreign_key: true
      # enumで定数を制限するため、integer方にしている。
      t.integer :action_type, null: false
      t.boolean :read, null: false, default: false

      t.timestamps
    end
  end
end
