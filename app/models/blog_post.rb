# blog_posts table Model
class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
end
