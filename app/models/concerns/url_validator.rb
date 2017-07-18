require 'uri'

class UrlValidator < ActiveModel::Validator

  def validate(record)
    if record.url?
      binding.pry
      uri = URI.parse(record.url)
      raise URI::InvalidURIError unless uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
        record.errors.add(:url, 'is invalid')
    end
  end
end
