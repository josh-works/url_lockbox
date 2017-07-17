require 'rails_helper'

RSpec.describe Link do
  context "validations" do
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:url)}
  end
end
