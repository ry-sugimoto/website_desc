class Website < ApplicationRecord
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true
  validate :valid_url_format

  private

  def valid_url_format
    uri = begin
      URI.parse(url)
    rescue StandardError
      false
    end
    errors.add(:url, "must be a valid URL") unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  end
end
