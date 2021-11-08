class Tweet < ApplicationRecord
  belongs_to :user
  
  has_many_attached :images
  
  scope :search1, -> (keyword){search(keyword).order(created_at: :desc)}
  
  #検索機能
  def self.search(keyword)
    where(["content like?", "%#{keyword}%"])
  end
  
  #いいね機能
  has_many :likes
  
  #コメント機能
  has_many :comments, dependent: :destroy
  
  validates :content, presence: true
end
