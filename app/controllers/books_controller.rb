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

  def create
    create_authors(params['authors'])
    @book = Book.find_or_create_by(
      title: params['title'],
      isbn: params['isbn'],
      description: params['description'],
      image_link: params['image_link']
    )
    create_user_read(@book, staus: params['status'])
    redirect_to root_path
  end

  def destroy
    book = Book.find_by(id: params['id'])
    UserRead.find_by(user: current_user, book: book).destroy
    book.destroy
    current_user.reload
    redirect_to root_path
  end

  private

  def book_params
    params.require(:book).permit(:title)
  end

  def create_authors(names)
    Array(names).each do |name|
      Author.find_or_create_by(name: name)
    end
  end

  def create_user_read(book, status)
    UserRead.create(user: current_user, book: book, rating: 5, status: params['status'])
  end
end
