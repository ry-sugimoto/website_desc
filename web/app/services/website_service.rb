class WebsiteService
  def self.find_or_create(url)
    website = Website.find_by(url: url)
    return website if website.present?

    # 対象HTMLを取得
    html = HtmlParser.html_text(url)
    # description取得
    description = External::OpenApiService.description(html)

    Website.create!(url: url, description: description)
  end
end
