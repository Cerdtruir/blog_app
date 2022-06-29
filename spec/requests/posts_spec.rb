require_relative '../rails_helper'
require_relative '../spec_helper'

describe 'Posts', type: :request do
  let!(:user) do
    User.create(name: 'fadfasd', photo: 'a.jpeg', bio: 'Example bio', posts_counter: 0)
  end

  context 'when getting index' do
    it 'should return a correct response' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(:ok)
    end

    it 'should return the correct page' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end

    it 'should return the correct text on page' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include('Number of posts:')
    end

    context 'when getting show page' do
      let!(:post) do
        Post.create(author: user, title: 'Example title', text: 'Example subject', comments_counter: 0,
                    likes_counter: 0)
      end

      it 'should return a correct response' do
        get "/users/#{user.id}/posts/#{post.id}"
        expect(response).to have_http_status(:ok)
      end

      it 'should return the correct page' do
        get "/users/#{user.id}/posts/#{post.id}"
        expect(response).to render_template(:show)
      end

      it 'should return the correct text on page' do
        get "/users/#{user.id}/posts/#{post.id}"
        expect(response.body).to include('Comments:')
      end
    end
  end
end
