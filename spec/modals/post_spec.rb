require_relative '../rails_helper'
require_relative '../spec_helper'

describe Post, type: :modal do
  user = User.create(name: 'fadfasd', photo: 'a.jpeg', bio: 'Example bio', posts_counter: 0)
  subject do
    Post.new(author: user, title: 'Example title', text: 'Example subject', comments_counter: 0, likes_counter: 0)
  end

  it 'should be valid when parameters are correct' do
    expect(subject).to be_valid
  end

  context 'Title' do
    it 'should be present' do
      subject.title = nil
      expect(subject).to be_invalid
    end

    it 'should be less than 250 characters' do
      subject.title = 'a' * 251
      expect(subject).to be_invalid
    end
  end

  context 'comments_counter' do
    it 'must be an integer greater than or equal to zero' do
      subject.comments_counter = 'a'
      expect(subject).to be_invalid

      subject.comments_counter = 4.332
      expect(subject).to be_invalid

      subject.comments_counter = -1
      expect(subject).to be_invalid

      subject.comments_counter = 0
      expect(subject).to be_valid

      subject.comments_counter = 3
      expect(subject).to be_valid
    end
  end

  context 'likes_counter' do
    it 'must be an integer greater than or equal to zero' do
      subject.likes_counter = 'a'
      expect(subject).to be_invalid

      subject.likes_counter = 4.332
      expect(subject).to be_invalid

      subject.likes_counter = -1
      expect(subject).to be_invalid

      subject.likes_counter = 0
      expect(subject).to be_valid

      subject.likes_counter = 3
      expect(subject).to be_valid
    end
  end

  context 'show_5_comments' do
    post = Post.new(author: user, title: 'Example title', text: 'Example subject', comments_counter: 0,
                    likes_counter: 0)

    it 'should return 5 comments sorted by newest first' do
      comments = []
      14.times do
        comments << Comment.create!(author: user, post:, text: 'Example comment')
      end
      expect(comments.length).to eq(14)
      expect(post.show_5_comments).to eq(comments.reverse.take(5))
    end
  end

  context 'update_post_counter' do
    it 'should update posts_counter of author' do
      user = User.create(name: 'fadfasd', photo: 'a.jpeg', bio: 'Example bio', posts_counter: 0)

      expect(user.posts_counter).to eq(0)

      Post.create(author: user, title: 'Example title', text: 'Example subject', comments_counter: 0,
                  likes_counter: 0)

      expect(user.posts_counter).to eq(1)
    end
  end
end
