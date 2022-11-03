class Comment < ApplicationRecord
  belongs_to :post, foreign_key: 'post_id'
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  after_save :update_comment_counter
  after_destroy :update_down_comment_counter
  private

  def update_comment_counter
    post.increment!(:comments_counter)
  end

  def update_down_comment_counter
    post.decrement!(:comments_counter)
  end
end
