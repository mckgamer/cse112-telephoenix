class Review < ActiveRecord::Base
  belongs_to :phone
  belongs_to :user
  attr_accessible :id, :user_id, :phone_id, :review_text, :rating
end
