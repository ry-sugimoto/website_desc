require 'rails_helper'
require 'webmock/rspec'

RSpec.describe "Api::Websites", type: :request do
  describe "GET /description" do
    context 'パスの確認' do
      let!(:path) { '/api/website/description' }
      it 'エンドポイントが想定通りであること' do
        expect(description_api_website_path).to eq path
      end
    end

    context '保存されていないurlを指定する場合' do
      let!(:url) { 'https://example.com' }
      let!(:html_body) { "<html><body><h1>Test</h1></body></html>" }
      let!(:api_url) { "https://api.openai.com/v1/chat/completions" }
      let!(:mock_response) { { choices: [{ message: { content: '〇〇の概要' } }] }.to_json }

      before do
        stub_request(:get, url).to_return(body: html_body, status: 200)
        stub_request(:post, api_url).to_return(body: mock_response, status: 200)
      end

      context 'urlの形式が正しい場合' do
        let!(:query_params) { { url: 'https://example.com' } }

        it 'リクエストに成功,レコードを保存しつつ概要を返すこと' do
          expect do
            get description_api_website_path, params: query_params
          end.to change(Website, :count).by(1)
          expect(response).to have_http_status(200)
          res = JSON.parse(response.body)
          website = Website.last
          expect(res['url']).to eq query_params[:url]
          expect(res['url']).to eq website.url
          expect(res['description']).to eq website.description
        end
      end

      context 'urlの形式が不正な場合' do
        let!(:query_params) do
          { url: 'example.com' }
        end
        it 'リクエストに失敗(400),URL不正エラーが返ること' do
          expect do
            get description_api_website_path, params: query_params
          end.to change(Website, :count).by(0)
          expect(response).to have_http_status(400)
          res = JSON.parse(response.body)
          expect(res['error']).to eq 'invalid url'
        end
      end
    end

    context '保存済みのurlを指定する場合' do
      let!(:website) { FactoryBot.create(:website) }
      let!(:query_params) { { url: website.url } }

      let!(:html_body) { "<html><body><h1>Test</h1></body></html>" }
      let!(:api_url) { "https://api.openai.com/v1/chat/completions" }
      let!(:mock_response) { { choices: [{ message: { content: '〇〇の概要' } }] }.to_json }

      before do
        stub_request(:get, website.url).to_return(body: html_body, status: 200)
        stub_request(:post, api_url).to_return(body: mock_response, status: 200)
      end

      it 'リクエストに成功,レコードは増えずに保存済みの概要を返すこと' do
        expect do
          get description_api_website_path, params: query_params
        end.to change(Website, :count).by(0)
        expect(response).to have_http_status(200)
        res = JSON.parse(response.body)
        expect(res['url']).to eq website.url
        expect(res['description']).to eq website.description
      end
    end
  end
end
