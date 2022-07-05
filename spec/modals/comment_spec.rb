require_relative '../rails_helper'
require_relative '../spec_helper'

describe Comment, type: :modal do
  context 'update_comments_counter' do
    it 'should update comments_counter of author' do
      user = User.create(email: 'userqwesad1@example.com', password: 'password', name: 'Example User1',
                         posts_counter: 0, photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      post = Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0,
                         likes_counter: 0)

      expect(post.comments_counter).to eq(0)

      Comment.create(author: user, post:, text: 'Example text')

      expect(post.comments_counter).to eq(1)
    end
  end
end
