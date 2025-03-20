class UrlValidator
  def self.valid?(url)
    uri = begin
      URI.parse(url)
    rescue StandardError
      false
    end
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  end
end
