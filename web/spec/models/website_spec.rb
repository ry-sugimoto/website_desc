require 'rails_helper'

RSpec.describe Website, type: :model do
  describe '正常系' do
    context 'urlの形式が正しい場合' do
      let!(:url) { 'https://example.com' }
      let!(:description) { '概要テスト' }

      it 'レコードを作成できること' do
        website = Website.create(url: url, description: description)
        expect(website.url).to eq url
        expect(website.description).to eq description
      end
    end
  end

  describe 'バリデーション' do
    context 'urlに空文字を指定する場合' do
      let!(:url) { '' }
      let!(:description) { '概要テスト' }

      it 'エラーになること' do
        website = Website.new(url: url, description: description)
        expect(website).not_to be_valid
      end
    end

    context 'urlにnilを指定する場合' do
      let!(:url) { nil }
      let!(:description) { '概要テスト' }

      it 'エラーになること' do
        website = Website.new(url: url, description: description)
        expect(website).not_to be_valid
      end
    end

    context 'url形式でない文字列をurlに指定する場合' do
      let!(:url) { 'example.com' }
      let!(:description) { '概要テスト' }

      it 'エラーになること' do
        website = Website.new(url: url, description: description)
        expect(website).not_to be_valid
      end
    end

    context 'urlに既に存在する値を指定する場合' do
      let!(:website1) { FactoryBot.create(:website) }

      it 'エラーになること' do
        website = Website.new(url: website1.url, description: website1.description)
        expect(website).not_to be_valid
      end
    end

    context 'descriptionに空文字を指定する場合' do
      let!(:url) { 'https://exemple.com' }
      let!(:description) { '' }

      it 'エラーになること' do
        website = Website.new(url: url, description: description)
        expect(website).not_to be_valid
      end
    end

    context 'descriptionにnilを指定する場合' do
      let!(:url) { 'https://exemple.com' }
      let!(:description) { nil }

      it 'エラーになること' do
        website = Website.new(url: url, description: description)
        expect(website).not_to be_valid
      end
    end
  end
end
