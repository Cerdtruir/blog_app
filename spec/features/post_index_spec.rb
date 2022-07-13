require_relative '../rails_helper'
require_relative '../spec_helper'

describe 'post index', type: :feature do
  context 'display the user details' do
    let!(:user) do
      User.create(email: 'useadsasdr1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                  photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
    end

    it 'displays the user name' do
      visit "/users/#{user.id}/posts"

      expect(page).to have_content('Example User1')
    end

    it 'displays the user photo' do
      visit "/users/#{user.id}/posts"

      expect(page).to have_css('img[src*="https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"]')
    end

    it 'displays the number of posts' do
      visit "/users/#{user.id}/posts"

      expect(page).to have_content('Number of posts:')
    end
  end

  context 'display the posts' do
    let!(:user) do
      User.create(email: 'useadsasdr1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                  photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
    end
    before(:each) do
      4.times do
        Post.create(author: user, title: 'Example title1', text: 'Example subject1', comments_counter: 0,
                    likes_counter: 0)
      end
    end

    it 'displays the posts' do
      visit "/users/#{user.id}/posts"

      expect(page).to have_content('Example title1', count: 4)
      expect(page).to have_content('Example subject1', count: 4)
    end

    it 'displays the posts likes counter' do
      post1 = Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0,
                          likes_counter: 0)

      Like.create(author: user, post: post1)
      Like.create(author: user, post: post1)

      visit "/users/#{User.last.id}/posts"

      expect(page).to have_content('Likes:2')
    end
  end

  context 'display the comments' do
    let!(:user) do
      User.create(email: 'useadsasdr1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                  photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
    end

    before(:each) do
      4.times do
        Post.create(author: user, title: 'Example title1', text: 'Example subject1', comments_counter: 0,
                    likes_counter: 0)
      end

      Comment.create(author: user, post: Post.last, text: 'Example comment1')
    end
    it 'displays the posts comments counter' do
      visit "/users/#{user.id}/posts"

      expect(page).to have_content('Comments:1')
      expect(page).to have_content('Comments:0')
    end

    it 'displays 5 of the latest posts comments' do
      5.times do
        Comment.create(author: user, post: Post.last, text: 'Example comment2')
      end

      visit "/users/#{user.id}/posts"

      expect(page).to have_content('Example comment2', count: 5)
      expect(page).to_not have_content('Example comment1')
    end
  end

  context 'pagintion' do
    let!(:user) do
      User.create!(email: 'usefghfghfr1@example.com', password: 'password', name: 'Example User1',
                   posts_counter: 0, photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
    end
    before(:each) do
      5.times do
        Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0,
                    likes_counter: 0)
      end

      Post.create(author: user, title: 'Example title6', text: 'Example subject', comments_counter: 0, likes_counter: 0)
    end
    it 'displays the pagination section' do
      visit "/users/#{user.id}/posts"

      expect(page).to have_content('Example title1', count: 5)
      expect(page).to_not have_content('Example title6')

      expect(page).to have_content('Last')
      expect(page).to have_content('Next')
    end

    it 'the pagination button works' do
      visit "/users/#{user.id}/posts"

      click_on 'Next'

      expect(page).to have_content('Example title6')
      expect(page).to_not have_content('Example title1')

      expect(page).to have_content('First')
      expect(page).to have_content('Prev')
    end
  end

  context 'post link' do
    it 'displays the post on click' do
      user = User.create(email: 'usewerwerr1@example.com', password: 'password', name: 'Example User1',
                         posts_counter: 0, photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      post1 = Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0,
                          likes_counter: 0)
      Post.create(author: user, title: 'Example title2', text: 'Example subject', comments_counter: 0,
                  likes_counter: 0)

      visit "/users/#{user.id}/posts"

      click_on "Post #{post1.id}"

      expect(page).to have_content('Example title1')
      expect(page).to have_content('Example subject')
      expect(page).to_not have_content('Example title2')
    end
  end
end
