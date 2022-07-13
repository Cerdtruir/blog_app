require_relative '../rails_helper'
require_relative '../spec_helper'

describe 'Users', type: :request do
  context 'when getting index' do
    it 'should return a correct response' do
      get '/users'
      expect(response).to have_http_status(:ok)
    end

    it 'should return the correct page' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'should return the correct text on page' do
      get '/users'
      expect(response.body).to include("<ul class='user_list'>")
    end

    context 'when getting show page' do
      let!(:user) do
        User.create!(email: 'userdasadf1@example.com', password: 'password', name: 'fadfasd',
                     photo: 'a.jpeg', bio: 'Example bio', posts_counter: 0)
      end

      it 'should return a correct response' do
        get "/users/#{user.id}"
        expect(response).to have_http_status(:ok)
      end

      it 'should return the correct page' do
        get "/users/#{user.id}"
        expect(response).to render_template(:show)
      end

      it 'should return the correct text on page' do
        get "/users/#{user.id}"
        expect(response.body).to include('Number of posts:')
      end
    end
  end
end
