class Message < ActiveRecord::Base
  belongs_to :chat
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :language

  validates_presence_of :body, :chat, :author
end

# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  chat_id     :integer
#  author_id   :integer
#  integer     :integer
#  language_id :integer
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_messages_on_chat_id      (chat_id)
#  index_messages_on_language_id  (language_id)
#
