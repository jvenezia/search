class App < ApplicationRecord
  validates :name, :link, :category, :rank, presence: true
  validates :name, uniqueness: {scope: [:category]}
end