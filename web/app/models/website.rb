class Website < ApplicationRecord
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true
  validate :valid_url_format

  private

  def valid_url_format
    errors.add(:url, "must be a valid URL") unless UrlValidator.valid?(url)
  end
end
