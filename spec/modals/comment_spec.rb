require_relative '../rails_helper'
require_relative '../spec_helper'

describe Comment, type: :modal do
  context 'update_comments_counter' do
    it 'should update comments_counter of author' do
      user = User.create(name: 'fadfasd', photo: 'a.jpeg', bio: 'Example bio', posts_counter: 0)
      post = Post.create(author: user, title: 'Example title', text: 'Example subject', comments_counter: 0,
                         likes_counter: 0)
      expect(post.comments_counter).to eq(0)

      Comment.create(author: user, post:, text: 'Example text')

      expect(post.comments_counter).to eq(1)
    end
  end
end
