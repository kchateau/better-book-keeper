class BooksController < ApplicationController
  def shelf
    @read_books = UserRead.where(user: current_user, status: 'read').order("created_at DESC")
    @want_to_read_books = UserRead.where(user: current_user, status: 'want_to_read')
  end

  def summary
    @read_books = UserRead.where(user: current_user, status: 'read').order("created_at DESC")
    @want_to_read_books = UserRead.where(user: current_user, status: 'want_to_read')
    @most_recent_read = UserRead.where(user: current_user).last
    @total_books_read = UserRead.where(user: current_user).count
  end

  def search 
    @book = Book.new
  end

  def more_info
    @book = Book.find(params['id'])
  end

  def search_results
    @books = GoogleBooks.search(book_params['title'], {:count => 10})
  end

  #move to user read controller
  def destroy
    book = Book.find_by(id: params['id'])
    UserRead.find_by(user: current_user, book: book).destroy
    current_user.reload
    redirect_to root_path
  end

  #more to user read controller
  def update
    book = Book.find(params['id'])
    read = UserRead.find_by(user: current_user, book: book)
    read.update(status: 'read')
    redirect_to root_path
  end

  private

  def book_params
    params.require(:book).permit(:title)
  end

  def create_authors(names)
    created_authors = []

    Array(names).each do |name|
      created_authors << Author.find_or_create_by(name: name)
    end

    created_authors
  end

  def create_user_read(book, status)
    UserRead.create(user: current_user, book: book, rating: 5, status: params['status'])
  end
end
