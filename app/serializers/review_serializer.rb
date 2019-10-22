class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :content_rating, :comment_rating, :average_rating, :picture
  belongs_to :book
  belongs_to :user
end
