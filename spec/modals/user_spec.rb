require_relative '../rails_helper'

describe User, type: :modal do
  subject do
    User.create(email: 'eweqqwdssfwer1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
  end

  context name do
    it 'should return false if name doesnt exist' do
      subject.name = nil
      expect(subject).to be_invalid
    end
  end

  context 'posts_counter' do
    it 'must be an integer greater than or equal to zero' do
      subject.posts_counter = 'a'
      expect(subject).to be_invalid

      subject.posts_counter = 4.332
      expect(subject).to be_invalid

      subject.posts_counter = -1
      expect(subject).to be_invalid

      subject.posts_counter = 0
      expect(subject).to be_valid

      subject.posts_counter = 3
      expect(subject).to be_valid
    end
  end

  context 'show_3_posts method' do
    it 'should return 3 posts' do
      user = User.create(email: 'uswdsc1@example.com', password: 'password', name: 'Example User1', posts_counter: 0,
                         photo: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
      posts = []
      14.times do
        posts << Post.create(author: user, title: 'Example title', text: 'Example subject', comments_counter: 0,
                             likes_counter: 0)
      end

      expect(user.show_3_posts.size).to eq(3)

      expect(user.show_3_posts).to eq posts.reverse[0..2]
    end
  end
end
