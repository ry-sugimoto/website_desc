module External
  class OpenApiService
    class << self
      def description(html)
        content = "下記htmlの内容を80文字以内に要約してください¥n#{html}"
        response = post_completions(content)

        if response.status == 200
          res = JSON.parse(response.body)
          res['choices'][0]['message']['content']
        else
          return nil
        end
      end

      private

      def post_completions(content)
        Faraday.post("https://api.openai.com/v1/chat/completions") do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['Authorization'] = "Bearer #{ENV['API_KEY']}"
          req.body = JSON.generate({
                                     model: "gpt-4o",
                                     messages: [
                                       { role: "user", content: content }
                                     ],
                                     max_tokens: 100
                                   })
        end
      end
    end
  end
end
