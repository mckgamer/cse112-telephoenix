class Review < ActiveRecord::Base
  belongs_to :phone
  belongs_to :user
  has_many :review_likes
  has_many :comments
 attr_accessible :id, :user, :phone, :review_text, :rating, :user_id, :phone_id

end
