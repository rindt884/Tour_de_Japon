class Post < ApplicationRecord
    
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  has_many :favorites, dependent: :destroy
  has_many_attached :images
  belongs_to :customer
    
end
