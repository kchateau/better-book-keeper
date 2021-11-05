class BooksController < ApplicationController
  def shelf
    @books = Book.where(user: current_user)
  end

  def search 
    @book = Book.new
  end

  def search_results
    @books = GoogleBooks.search(book_params['title'], {:count => 10})
  end

  private

  def book_params
    params.require(:book).permit(:title)
  end
end
