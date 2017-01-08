require 'rails_helper'

describe App do
  it { should validate_presence_of :name }
  it { should validate_presence_of :link }
  it { should validate_presence_of :category }
  it { should validate_presence_of :rank }

  it { should validate_uniqueness_of(:name).scoped_to(:category) }

  it { should validate_numericality_of(:rank) }

  describe 'link' do
    subject { create :app }

    it { should allow_value('https://zelda.net').for(:link) }
    it { should allow_value('http://zelda.net').for(:link) }
    it { should allow_value('zelda.net').for(:link) }
    it { should_not allow_value('zelda').for(:link) }
  end

  describe 'image' do
    subject { create :app }

    it { should allow_value('https://nice.net').for(:image) }
    it { should allow_value('http://nice.net').for(:image) }
    it { should allow_value('nice.net').for(:image) }
    it { should allow_value('').for(:image) }
    it { should_not allow_value('zelda').for(:image) }
  end

  describe 'clean_names' do
    let(:app) { create :app, name: '<script>alert("Hello!")</script> Awesome', category: '<b>New</b> App' }

    it { expect(app.name).to eq 'Awesome' }
    it { expect(app.category).to eq 'New App' }
  end
end