class Api::V1::BooksController < ApplicationController
  before_action :load_book, only: :show
  def index
    @books = Book.all
    book_serializer = parse_json @books
    json_response "Index of books is successfull", true, {books: book_serializer}, :ok
  end

  def show
    book_serializer = parse_json @book
    json_response "Book successfully displayed", true, {book: book_serializer}, :ok
  end

  private
  def load_book
    @book = Book.find_by id: params[:id]
    unless @book.present?
      json_response "No book found", false, {}, :not_found
    end
  end
end
