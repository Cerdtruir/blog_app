require_relative '../rails_helper'

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
      expect(response.body).to include('Users index')
    end

    context 'when getting show page' do
      it 'should return a correct response' do
        get '/users/1'
        expect(response).to have_http_status(:ok)
      end

      it 'should return the correct page' do
        get '/users/1'
        expect(response).to render_template(:show)
      end

      it 'should return the correct text on page' do
        get '/users/1'
        expect(response.body).to include('users show')
      end
    end
  end
end
