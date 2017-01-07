class App < ApplicationRecord
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
end