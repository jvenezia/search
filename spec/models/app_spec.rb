require 'rails_helper'

describe App do
  it { should validate_presence_of :name }
  it { should validate_presence_of :link }
  it { should validate_presence_of :category }
  it { should validate_presence_of :rank }

  it { should validate_uniqueness_of(:name).scoped_to(:category) }
end