require 'swagger_helper'

RSpec.describe 'api/comments', type: :request do
  path '/users/{user_id}/posts/{post_id}/comments.json' do
    get 'Retrieves all comments' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string

      response '200', 'Comments retrieved' do
        run_test!
      end
    end

    post 'Creates a comment' do
      tags 'Comments'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: %w[text]
      }

      response '201', 'Comment created' do
        run_test!
      end
    end
  end
end
