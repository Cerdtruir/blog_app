require_relative '../rails_helper'

describe 'requests to controllers' do
  context 'users requests' do
    it 'should return a correct response when getting index' do
      get '/users'
      expect(response).to have_http_status(:ok)
    end

    it 'should return the correct page when getting index' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'should return a correct when getting a show page' do
      get '/users/1'
      expect(response).to have_http_status(:ok)
    end

    it 'should return the correct page when getting a show page' do
      get '/users/1'
      expect(response).to render_template(:show)
    end
  end

  context 'posts requests' do
    it 'should return a correct response when getting index' do
      get '/users/1/posts'
      expect(response).to have_http_status(:ok)
    end

    it 'should return the correct page when getting index' do
      get '/users/1/posts'
      expect(response).to render_template(:index)
    end

    it 'should return a correct when getting a show page' do
      get '/users/1/posts/1'
      expect(response).to have_http_status(:ok)
    end

    it 'should return the correct page when getting a show page' do
      get '/users/1/posts/1'
      expect(response).to render_template(:show)
    end
  end
end
