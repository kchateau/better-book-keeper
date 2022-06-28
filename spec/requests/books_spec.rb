require 'rails_helper'

RSpec.describe BooksController, :type => :request do
  let(:user) { create(:user) }
  let!(:user_book_1) { 
    create(
      :user_read,
      user: user,
      book: create(:book, title: 'Book 1', isbn: "1234567", description: "This is a book."),
      status: 'read'
    )
  }

  let!(:user_book_2) { create(:user_read, user: user, book: create(:book, title: 'Book 2'), status: 'want_to_read') }

  describe "#shelf" do

    it "displays the shelf page" do
      get "/books/shelf"

      expect(response).to be_successful
      expect(response.body).to include("Read")
      expect(response.body).to include("Want to Read")
    end

    it "returns the users want_to_read_book's" do
      
    end
  end

  describe "#summary" do
    it "displays the summary page" do
      sign_in user
      get "/books/summary"

      expect(response).to be_successful
      expect(response.body).to include("Total books read: 2")
      expect(response.body).to include("Most Recent Read: Book 2")
    end
  end

  describe "#search" do
    it "displays the search page" do
      get "/books/search"

      expect(response).to be_successful
      expect(response.body).to include("Search book by title")
    end
  end

  describe "#more_info" do
    it "displays the more info page for the given book" do
      get "/books/more_info?id=#{user_book_1.id}"

      expect(response).to be_successful
      expect(response.body).to include("Book 1")
      expect(response.body).to include("1234567")
      expect(response.body).to include("This is a book.")
    end
  end

  #describe "#search_results" do

  #end
end
