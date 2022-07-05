require_relative '../rails_helper'
require_relative '../spec_helper'

describe 'user index', type: :feature do
  context 'display index page' do
    it 'displays the usernames of all users' do
      User.create(email: 'user1123123@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                  photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
      User.create(email: 'user1232132@example.com', password: 'password', name: 'Example User2', posts_counter: 0,
                  photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
      User.create(email: 'user123123@example.com', password: 'password', name: 'Example User3', posts_counter: 0,
                  photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')

      visit '/users'

      expect(page).to have_content('Example User1')
      expect(page).to have_content('Example User2')
      expect(page).to have_content('Example User3')
    end

    it 'displays the images of all users' do
      User.create(email: 'user123122341@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                  photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
      User.create(email: 'user464562@example.com', password: 'password', name: 'Example User2', posts_counter: 0,
                  photo: '1.jpg')
      User.create(email: 'user3sfsdf@example.com', password: 'password', name: 'Example User3', posts_counter: 0,
                  photo: '2.jpg')

      visit '/users'

      expect(page).to have_css('img[src*="https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"]')
      expect(page).to have_css('img[src*="1.jpg"]')
      expect(page).to have_css('img[src*="2.jpg"]')
    end

    it 'displays the post counts of all users' do
      User.create(email: 'usersfsd1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                  photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
      User.create(email: 'user2sfgsdg@example.com', password: 'password', name: 'Example User2', posts_counter: 10,
                  photo: '1.jpg')
      User.create(email: 'usergfhfgh3@example.com', password: 'password', name: 'Example User3', posts_counter: 55,
                  photo: '2.jpg')

      visit '/users'

      expect(page).to have_content('Number of posts: 0')
      expect(page).to have_content('Number of posts: 10')
      expect(page).to have_content('Number of posts: 55')
    end
  end

  context 'display user page on click' do
    it 'displays the user page' do
      User.create(email: 'userfhfgh1@example.com', password: 'password', name: 'ExampleUser1', posts_counter: 0,
                  photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
      User.create(email: 'user2fhfghfgh@example.com', password: 'password', name: 'ExampleUser2', posts_counter: 10,
                  photo: '1.jpg')
      User.create(email: 'user3fhfgh@example.com', password: 'password', name: 'ExampleUser3', posts_counter: 55,
                  photo: '2.jpg')

      visit '/users'

      click_link('user-link-ExampleUser1')

      expect(page).to have_content('ExampleUser1')
      expect(page).to have_content('Bio:')
    end
  end
end
