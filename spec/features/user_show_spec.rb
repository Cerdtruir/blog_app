require_relative '../rails_helper'
require_relative '../spec_helper'

describe 'user show page', type: :feature do
  context 'Does user show page load' do
    let!(:user) do
      User.create(email: 'useadsasdr1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                  photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
    end
    it 'displays the user name' do
      visit "/users/#{user.id}"
      expect(page).to have_content('Example User1')
    end

    it 'displays the user bio' do
      visit "/users/#{user.id}"
      expect(page).to have_content('Bio:')
    end

    it 'displays the user photo' do
      visit "/users/#{user.id}"
      expect(page).to have_css('img[src*="https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"]')
    end

    it 'displays the number of posts' do
      visit "/users/#{user.id}"
      expect(page).to have_content('Number of posts:')
    end

    it 'displays the first 3 posts' do
      Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title2', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title3', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title4', text: 'Example subject', comments_counter: 0, likes_counter: 0)

      visit "/users/#{User.last.id}"
      expect(page).to have_content('Example title4')
      expect(page).to have_content('Example title2')
      expect(page).to have_content('Example title3')
      expect(page).to_not have_content('Example title1')
    end

    it 'displays a link to view all posts' do
      visit "/users/#{user.id}"
      expect(page).to have_link('See all posts')
    end
  end

  context 'Does clicked post page load' do
    it 'displays post page on click' do
      user = User.create(email: 'useadsasdr1@example.com', password: 'password',
                         name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      post = Post.create(author: user, title: 'Example title 1', text: 'Example subject', comments_counter: 0,
                         likes_counter: 0)

      visit "/users/#{user.id}"

      click_link "Post #{post.id}"

      expect(page).to have_content('Example title 1')
      expect(page).to have_content('Example subject')
    end
  end

  context 'Does the all posts page load' do
    it 'displays thr all posts page' do
      user = User.create(email: 'useadsasdr1@example.com', password: 'password',
                         name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title2', text: 'Example subject', comments_counter: 0, likes_counter: 0)

      visit "/users/#{user.id}"

      click_link 'See all posts'

      expect(page).to have_content('Example title1')
      expect(page).to have_content('Example title2')
    end
  end
end
