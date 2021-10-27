class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  has_and_belong_to_many :categories
  has_many :authors
  has_many :user_reads
end
