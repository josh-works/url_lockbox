require 'uri'

class Link < ActiveRecord::Base

  validates :url, :presence => true, :url => true
  validates :title, :url, presence: true
  belongs_to :user
end
