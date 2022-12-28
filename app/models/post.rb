class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title ,use: %i[slugged history] 
  
  belongs_to :account
  belongs_to :community
  validates_presence_of :title, :body, :account_id, :community_id
  has_many :comments
  belongs_to :report
  has_rich_text :body 
  has_many_attached :images

  def score
    # difference between upvotes and downvotes
    if self.upvotes > 0 || self.downvotes > 0
      self.upvotes > 0 ? (self.upvotes - self.downvotes) : (self.downvotes * -1)
    else
      0
    end
  end
  
  def should_generate_new_friendly_id?
    title_changed? || slug.blank?
  end
end    
