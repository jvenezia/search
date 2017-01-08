class App < ApplicationRecord
  include AlgoliaSearch

  validates :name, :link, :category, :rank, presence: true
  validates :name, uniqueness: {scope: [:category]}
  validates :rank, numericality: true

  validates :link, url: {no_local: true}
  validates :image, url: {no_local: true, allow_nil: true, allow_blank: true}

  before_validation :clean_urls

  def clean_urls
    link.prepend('http://') if link.present? && !link.start_with?('http')
    image.prepend('http://') if image.present? && !image.start_with?('http')
  end

  algoliasearch index_name: "#{ENV['ALGOLIA_INDEX_NAME']}_#{Rails.env}", disable_indexing: Rails.env.test? do
    attribute :id, :name, :category, :link, :image, :rank, :created_at, :updated_at
    searchableAttributes %w(name category)
    customRanking ['asc(rank)']
  end
end