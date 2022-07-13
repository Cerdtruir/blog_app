require_relative '../rails_helper'
require_relative '../spec_helper'

describe 'post index', type: :feature do
  context 'display the user details' do
    it 'displays the user name' do
      user = User.create(email: 'userqweqwdsc1@example.com', password: 'password', name: 'Example User1',
                         posts_counter: 0, photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      visit "/users/#{user.id}/posts"

      expect(page).to have_content('Example User1')
    end

    it 'displays the user photo' do
      user = User.create(email: 'usegjghjghj1@example.com', password: 'password', name: 'Example User1',
                         posts_counter: 0, photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      visit "/users/#{user.id}/posts"

      expect(page).to have_css('img[src*="https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"]')
    end

    it 'displays the number of posts' do
      user = User.create(email: 'usegdfgfdr1@example.com', password: 'password', name: 'Example User1',
                         posts_counter: 0, photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      visit "/users/#{user.id}/posts"

      expect(page).to have_content('Number of posts:')
    end
  end

  context 'display the posts' do
    it 'displays the posts titles' do
      user = User.create(email: 'userasfhfdasda1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title2', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title3', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title4', text: 'Example subject', comments_counter: 0, likes_counter: 0)

      visit "/users/#{User.last.id}/posts"

      expect(page).to have_content('Example title1')
      expect(page).to have_content('Example title2')
      expect(page).to have_content('Example title3')
      expect(page).to have_content('Example title4')
    end

    it 'displays the posts text' do
      user = User.create(email: 'userfghfghfg1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      Post.create(author: user, title: 'Example title1', text: 'Example subject1', comments_counter: 0,
                  likes_counter: 0)
      Post.create(author: user, title: 'Example title2', text: 'Example subject2', comments_counter: 0,
                  likes_counter: 0)
      Post.create(author: user, title: 'Example title3', text: 'Example subject3', comments_counter: 0,
                  likes_counter: 0)
      Post.create(author: user, title: 'Example title4', text: 'Example subject4', comments_counter: 0,
                  likes_counter: 0)

      visit "/users/#{User.last.id}/posts"

      expect(page).to have_content('Example subject1')
      expect(page).to have_content('Example subject2')
      expect(page).to have_content('Example subject3')
      expect(page).to have_content('Example subject4')
    end

    it 'displays the posts comments counter' do
      user = User.create(email: 'userdfwfsgs1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      post1 = Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0,
                          likes_counter: 0)
      Post.create(author: user, title: 'Example title2', text: 'Example subject', comments_counter: 0, likes_counter: 0)

      Comment.create(author: user, post: post1, text: 'Example comment')

      visit "/users/#{User.last.id}/posts"

      expect(page).to have_content('Comments:1')
      expect(page).to have_content('Comments:0')
    end

    it 'displays 5 of the latest posts comments' do
      user = User.create(email: 'usfghfghfgjer1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      post1 = Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0,
                          likes_counter: 0)
      Post.create(author: user, title: 'Example title2', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title3', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title4', text: 'Example subject', comments_counter: 0, likes_counter: 0)

      Comment.create(author: user, post: post1, text: 'Example comment1')
      Comment.create(author: user, post: post1, text: 'Example comment2')
      Comment.create(author: user, post: post1, text: 'Example comment3')
      Comment.create(author: user, post: post1, text: 'Example comment4')
      Comment.create(author: user, post: post1, text: 'Example comment5')
      Comment.create(author: user, post: post1, text: 'Example comment6')

      visit "/users/#{User.last.id}/posts"

      expect(page).to have_content('Example comment6')
      expect(page).to have_content('Example comment2')
      expect(page).to have_content('Example comment3')
      expect(page).to have_content('Example comment4')
      expect(page).to have_content('Example comment5')
      expect(page).to_not have_content('Example comment1')
    end

    it 'displays the posts likes counter' do
      user = User.create(email: 'usesdghdfgr1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      post1 = Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0,
                          likes_counter: 0)

      Like.create(author: user, post: post1)
      Like.create(author: user, post: post1)

      visit "/users/#{User.last.id}/posts"

      expect(page).to have_content('Likes:2')
    end
  end

  context 'pagintion' do
    it 'displays the pagination section' do
      user = User.create(email: 'usefghfghfr1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title2', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title3', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title4', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title5', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title6', text: 'Example subject', comments_counter: 0, likes_counter: 0)

      visit "/users/#{User.last.id}/posts"

      expect(page).to have_content('Example title1')
      expect(page).to have_content('Example title2')
      expect(page).to have_content('Example title3')
      expect(page).to have_content('Example title4')
      expect(page).to have_content('Example title5')
      expect(page).to_not have_content('Example title6')

      expect(page).to have_content('Last')
      expect(page).to have_content('Next')
    end

    it 'the pagination button works' do
      user = User.create(email: 'usefghfghfghr1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      Post.create(author: user, title: 'Example title1', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title2', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title3', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title4', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title5', text: 'Example subject', comments_counter: 0, likes_counter: 0)
      Post.create(author: user, title: 'Example title6', text: 'Example subject', comments_counter: 0, likes_counter: 0)

      visit "/users/#{User.last.id}/posts"

      click_on 'Next'

      expect(page).to have_content('Example title6')
      expect(page).to_not have_content('Example title1')
      expect(page).to_not have_content('Example title2')
      expect(page).to_not have_content('Example title3')
      expect(page).to_not have_content('Example title4')
      expect(page).to_not have_content('Example title5')

      expect(page).to have_content('First')
      expect(page).to have_content('Prev')
    end
  end

  context 'post link' do
    it 'displays the post on click' do
      user = User.create(email: 'usewerwerr1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

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
