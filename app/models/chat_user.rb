class ChatUser < ActiveRecord::Base
  belongs_to :chat
  belongs_to :user

  validates_presence_of :chat, :user

  validates :chat, uniqueness: { scope: :user }
  validates :user, uniqueness: { scope: :chat }
end

# == Schema Information
#
# Table name: chat_users
#
#  id         :integer          not null, primary key
#  chat_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chat_users_on_chat_id  (chat_id)
#  index_chat_users_on_user_id  (user_id)
#
