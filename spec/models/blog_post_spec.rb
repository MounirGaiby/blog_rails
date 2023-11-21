# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  describe '#draft?' do
    it 'returns true if blog is draft' do
      expect(BlogPost.new(published_at: nil).draft?).to be_truthy
    end
    it 'returns false if blog is published' do
      expect(BlogPost.new(published_at: 1.year.ago).draft?).to be_falsey
    end

    it 'returns false if blog is scheduled' do
      expect(BlogPost.new(published_at: 1.year.from_now).draft?).to be_falsey
    end
  end

  describe '#published?' do
    it 'returns true if blog is published' do
      expect(BlogPost.new(published_at: Time.now - 1.day).published?).to be_truthy
    end
  end

  describe '#scheduled?' do
    it 'returns true if blog is scheduled' do
      expect(BlogPost.new(published_at: Time.now + 1.day).scheduled?).to be_truthy
    end
  end
end
