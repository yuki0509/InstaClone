# == Schema Information
#
# Table name: activities
#
#  id           :bigint           not null, primary key
#  action_type  :integer          not null
#  read         :boolean          default(FALSE), not null
#  subject_type :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  subject_id   :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_activities_on_subject_type_and_subject_id  (subject_type,subject_id)
#  index_activities_on_user_id                      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Activity < ApplicationRecord
  # ポリモーフィック関連づけを行っている。
  belongs_to :subject, polymorphic: true
  belongs_to :user

  # enumは、一つのカラムに指定した複数個の定数を保存できるようにする。データベースにはハッシュのバリューが保存され、action_typeカラムにはハッシュのキー名を保存する。
  enum action_type: { commented_to_own_post: 0, liked_to_own_post: 1, followed_me: 2 }
end
