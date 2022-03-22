require 'rails_helper'

describe BooksController, type: :controller do
  let(:user) { create(:user) }

  describe '#create' do
    context 'the book already exists' do
      subject { get :create, :params => { 
        :title => 'Dune',
        :isbn => '12345',
        :description => 'This is the description',
        :image_link => 'image.png',
        :authors => ['asd'],
        :status => 'read'
        }
      }

      let!(:book) { create(:book, title: 'Dune', isbn: '12345', description: 'This is the description', image_link: 'image.png') }
      let(:user_read) { create(:user_read, book: book, user: user) }
      let!(:author) { create(:author, name: 'asd') }

      it 'does not create an author' do
        expect { subject }.not_to change { Author.count }
      end

      it 'does not create a book' do
        expect { subject }.not_to change { Book.count }
      end

      it 'does not create a user read' do
        expect { subject }.not_to change { UserRead.count }
      end

      it { is_expected.to redirect_to root_path }
    end

    context 'the book does not exist' do
      subject { get :create, :params => { 
        :title => 'Dune',
        :isbn => '12345',
        :description => 'This is the description',
        :image_link => 'image.png',
        :authors => ['asd'],
        :status => 'read'
        }
      }

      before do
        sign_in user
      end

      it 'creates the authors' do
        expect { subject }.to change { Author.count }.from(0).to(1)
      end

      it 'creates the book' do
        expect { subject }.to change { Book.count }.from(0).to(1)

        expect(Book.last.title).to eq 'Dune'
        expect(Book.last.isbn).to eq '12345'
        expect(Book.last.description).to eq 'This is the description'
        expect(Book.last.image_link).to eq 'image.png'
        expect(Book.last.authors).to eq Author.where(name: 'asd')
      end

      it 'creates the user read' do
        expect { subject }.to change { UserRead.count }.from(0).to(1)
      end
    end

    it { is_expected.to redirect_to root_path }
  end
end
