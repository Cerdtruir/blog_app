require 'swagger_helper'

describe 'Posts API', type: :request do
  path '/users/{user_id}/posts.json' do
    get 'Retrieves all posts' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string

      response '200', 'Posts retrieved' do
        run_test!
      end
    end
  end
end
