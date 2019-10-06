class Post < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 20 }
  validates :comment, presence: true, length: { maximum: 255 }
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader
  
  #お気に入り
  has_many :favorites
  has_many :users, through: :favorites, dependent: :destroy
  
  #コメント
  has_many :messages
end
