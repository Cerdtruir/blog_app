require_relative '../rails_helper'
require_relative '../spec_helper'

describe Like, type: :modal do
  context 'update_likes_counter' do
    it 'should update likes_counter of author' do
      user = User.create(email: 'userqwesad1asd@example.com', password: 'password', name: 'Example User1',
                         posts_counter: 0, photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
      post = Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0,
                         likes_counter: 0)

      expect(post.likes_counter).to eq(0)

      Like.create(author: user, post:)

      expect(post.likes_counter).to eq(1)
    end
  end
end
