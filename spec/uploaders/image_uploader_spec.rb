require 'rails_helper'

describe ImageUploader do
  include CarrierWave::Test::Matchers

  let(:movie) { create :movie }
  let(:uploader) { described_class.new(movie, :images) }

  before do
    described_class.enable_processing = true
    File.open(Rails.root.join('spec/fixtures/posters/test.jpg')) { |f| uploader.store!(f) }
  end

  after do
    described_class.enable_processing = false
    uploader.remove!
  end

  describe '.resize_to_fit' do
    it 'when images have valid size' do
      expect(uploader).to be_no_larger_than(1280, 720)
    end

    it 'when images have invalid size' do
      expect(uploader).not_to be_no_larger_than(100, 100)
    end
  end

  describe '.extension_allowlist' do
    it 'has the correct format' do
      expect(uploader).to be_format('jpeg')
    end

    it 'has the incorrect format' do
      expect(uploader).not_to be_format('gif')
    end
  end
end
