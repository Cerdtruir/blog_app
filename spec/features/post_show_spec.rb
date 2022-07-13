require_relative '../rails_helper'
require_relative '../spec_helper'

describe 'post show', type: :feature do
  context 'display post show page' do
    let!(:user) do
      User.create(email: 'useadsasdr1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                  photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
    end
    let!(:post) do
      Post.create(author: user, title: 'Example title1', text: 'Example subject',
                  comments_counter: 0, likes_counter: 0)
    end
    it 'displays the post' do
      visit "users/#{user.id}/posts/#{post.id}"
      expect(page).to have_content('Example title1')
      expect(page).to have_content('Example subject')
    end

    it 'displays the post author' do
      visit "users/#{user.id}/posts/#{post.id}"
      expect(page).to have_content('Example User1')
    end

    it 'displays the comment counter' do
      Comment.create(text: 'Example Comment', author: user, post:)

      visit "users/#{user.id}/posts/#{post.id}"
      expect(page).to have_content('Comments:1')
    end

    it 'displays the likes counter' do
      Like.create(author: user, post:)

      visit "users/#{user.id}/posts/#{post.id}"
      expect(page).to have_content('Likes:1')
    end
  end
  context 'display post show comments' do
    let!(:user) do
      User.create(email: 'useadsasdr1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                  photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
    end
    let!(:post) do
      Post.create(author: user, title: 'Example title1', text: 'Example subject',
                  comments_counter: 0, likes_counter: 0)
    end
    it 'displays the comments with author' do
      comment_user = User.create(email: 'user2asdasda@example.com', password: 'password',
                                 name: 'Example User1', posts_counter: 0,
                                 photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
      4.times do
        Comment.create(author: comment_user, post:, text: 'Example comment1')
      end

      visit "users/#{user.id}/posts/#{post.id}"
      expect(page).to have_content('Example comment1', count: 4)
      expect(page).to have_content(comment_user.name)
    end
  end
end
