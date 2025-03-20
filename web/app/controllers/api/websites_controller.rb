module Api
  class WebsitesController < ApplicationController
    def description
      url = params[:url]

      render status: :bad_request, json: { error: 'invalid url' } and return unless UrlValidator.valid?(url)

      @website = WebsiteService.find_or_create(url)
      render status: :ok, json: @website
    end
  end
end
