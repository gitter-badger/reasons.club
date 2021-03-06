class Issue < ActiveRecord::Base

  has_many :reasons
  has_many :most_voted_reasons, -> { order('reasons.votes_positive DESC') }, class_name: 'Reason'
  # Issue.includes(:most_voted_reasons) 

  belongs_to :user
  
  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Common
  
  validates :title, presence: true, length: { minimum: 10 }

  scope :public_issues, -> { where(privacy_public: 2) }
  scope :featured, -> { where(featured: 1) }

end