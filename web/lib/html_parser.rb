require 'open-uri'

class HtmlParser
  def self.html_text(url)
    doc = Nokogiri::HTML(URI.parse(url).read)
    doc.search('script, style').each(&:remove)
    doc.css('body').text.strip
  end
end
