class Review < ApplicationRecord
  before_validation :parse_image
  before_save :calculate_rating
  belongs_to :user
  belongs_to :book

  counter_culture :book

  attr_accessor :image_review

  has_attached_file :picture, styles: {medium: "300x300>", thumb: "100x100>"}
  validates_attachment :picture, presence: true
  do_not_validate_attachment_file_type :picture

  private
  def parse_image
    image = Paperclip.io_adapters.for image_review
    image.original_file_name = "review.jpg"
    self.picture = image
  end
  def calculate_rating
    self.average_rating = ((self.content_rating.to_f + self.comment_rating.to_f) / 2).round(1)
  end
end
