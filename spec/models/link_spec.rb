require 'rails_helper'

RSpec.describe Link do
  context "validations" do
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:url)}

    it "should not save invalid ULR" do
      title = "test url"
      invalid_url = "www.google"

      link = Link.new(title: title, url: invalid_url)
      expect {link.save}.to raise_error(URI::InvalidURIError)

    end
    it "should save valid URL" do
      title = "test url"
      valid_url = "http://google.com"

      Link.create!(title: title, url: valid_url)
      expect(Link.count).to eq(1)

    end
  end

  context "associations" do
    it { should belong_to(:user)}
  end
end
