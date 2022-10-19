class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def update_counter
    posts.increment!(:comments_counter)
  end
end
