class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :article
  belongs_to :parent, :class_name => "Comment"
  has_many :comments, :foreign_key => "parent_id"
  validates :user_id, :comment, :article_id, :presence => true

end
