class User < ApplicationRecord
  belongs_to :city
  has_many :gossips
  has_many :comments
  has_many :private_messages, foreign_key: :sender_id
  has_many :likes

  
  has_many :received_messages, class_name: 'PrivateMessage', foreign_key: :recipient_id
end
