class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      # ポリモーフィック関連。object.subjectでオブジェクトのクラスを気にせずに対応する値がとれる。
      t.references :subject, polymorphic: true
      t.references :user, foreign_key: true
      # enumでactio_typeの値を制限するため、integer型にしている。
      t.integer :action_type, null: false
      # enumでreadの値を制限するため、boolean型にしている。boolean型の場合は、defaultの値を入れておく。
      t.boolean :read, null: false, default: false

      t.timestamps
    end
  end
end
