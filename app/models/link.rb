require 'uri'

class Link < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with UrlValidator

  validates :title, :url, presence: true
  belongs_to :user






end
