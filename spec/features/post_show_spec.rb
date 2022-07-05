require_relative '../rails_helper'
require_relative '../spec_helper'

describe 'post show', type: :feature do
  context 'display post show page' do
    it 'displays the post title' do
      user = User.create(email: 'userqweqwdsc1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      post = Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0,
                         likes_counter: 0)

      visit "users/#{user.id}/posts/#{post.id}"

      expect(page).to have_content('Example title1')
    end

    it 'displays the post content' do
      user = User.create(email: 'useasdasdar1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      post = Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0,
                         likes_counter: 0)

      visit "users/#{user.id}/posts/#{post.id}"

      expect(page).to have_content('Example subject')
    end

    it 'displays the post author' do
      user = User.create(email: 'usasdasdaser1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      post = Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0,
                         likes_counter: 0)

      visit "users/#{user.id}/posts/#{post.id}"

      expect(page).to have_content('Example User1')
    end

    it 'displays the comment counter' do
      user = User.create(email: 'usasdasdasder1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      post = Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0,
                         likes_counter: 0)

      Comment.create(text: 'Example Comment', author: user, post:)

      visit "users/#{user.id}/posts/#{post.id}"

      expect(page).to have_content('Comments:1')
    end

    it 'displays the likes counter' do
      user = User.create(email: 'usqadasdader1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      post = Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0,
                         likes_counter: 0)

      Like.create(author: user, post:)

      visit "users/#{user.id}/posts/#{post.id}"

      expect(page).to have_content('Likes:1')
    end

    it 'displays the comments with author' do
      user = User.create(email: 'user1asdasdas@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      comment_user = User.create(email: 'user2asdasda@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                                 photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      post = Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0,
                         likes_counter: 0)

      Comment.create(author: comment_user, post:, text: 'Example comment1')
      Comment.create(author: comment_user, post:, text: 'Example comment2')
      Comment.create(author: comment_user, post:, text: 'Example comment3')
      Comment.create(author: comment_user, post:, text: 'Example comment4')

      visit "users/#{user.id}/posts/#{post.id}"

      expect(page).to have_content('Example comment1')
      expect(page).to have_content('Example comment2')
      expect(page).to have_content('Example comment3')
      expect(page).to have_content('Example comment4')

      expect(page).to have_content(comment_user.name)
    end
  end
end
