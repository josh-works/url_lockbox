require 'rails_helper'

describe 'LINKS API' do

  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  context 'PATCH /api/v1/links/' do
    it 'updates given link' do
      link = create(:link)

      expect(link.read).to eq(false)

      params =  {
        id: link.id,
        read: true
      }

      patch "/api/v1/links/#{link.id}", params: params
      expect(response.status).to be(200)

      updated_link = JSON.parse(response.body)
      expect(updated_link["read"]).to eq(true)
      expect(Link.first.read).to eq(true)

    end

  end


end
