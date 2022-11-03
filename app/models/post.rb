class Post < ApplicationRecord
  
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy, foreign_key: 'post_id'
  has_many :likes, dependent: :destroy, foreign_key: 'post_id'
  
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comment
    comments.includes([:author]).last(5)
  end

  after_save :update_post_counter
  after_destroy :update_down_post_counter
  private

  def update_post_counter
    author.increment!(:posts_counter)
  end

  def update_down_post_counter
    author.decrement!(:posts_counter)
  end
end
