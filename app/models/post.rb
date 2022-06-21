class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  def show_5_comments
    comments.order('created_at DESC').limit(5)
  end
end
