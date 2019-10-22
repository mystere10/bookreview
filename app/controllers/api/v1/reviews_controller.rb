class Api::V1::ReviewsController < ApplicationController
  before_action :load_book, only: :index
  before_action :load_review, only: [:show, :update, :destroy]
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]

  def index
    @reviews = @book.reviews
    json_response "List of books", true, {reviews: @reviews}, :ok
  end

  def show
    json_response "One book", true, {books: @review}, :ok
  end

  def create
    review = Review.new review_params
    review.user_id = current_user.id
    review.book_id = params[:book_id]

    if review.save
      json_response "Review created", true, {review: review}, :ok
    else
      json_response "Review not created", false, {}, :unprocessed_intity
    end
  end

  def update
    if correct_user @review.user
      if @review.update review_params
        json_response "Review updated", true, {review: @review}, :ok
      else
        json_response "Updating review failed", false, {}, :unprocessed_intity
      end
    else
      json_response "Edit not allowed", false, {}, :unauthorised
    end
  end

  def destroy
    if correct_user @review.user
      if @review.destroy review_params
        json_response "Review deleted successfullt", true, {review: @review}, :ok
      else
        json_response "Review deletion failed", false, {}, :unprocessed_intity
      end
    else
      json_response "Edit not allowed", false, {}, :unauthorised
    end
  end

  private
  def load_book
    @book = Book.find_by id: params[:id]
    unless @book.present?
      json_response "No book found", false, {}, :not_found
    end
  end

  def load_review
    @review = Review.find_by id: params[:id]
    unless @review.present?
      json_response "No review found", false, {}, :not_found
    end
  end

  def review_params
    params.require(:review).permit :title, :content_rating, :comment_rating
  end
end
