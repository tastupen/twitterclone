class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  
  has_one_attached :avatar
  
  has_many :tweets, dependent: :destroy
  
  #いいね機能
  has_many :likes, dependent: :destroy
  
  def liked_by?(tweet_id)
    likes.where(tweet_id: tweet_id).exists?
  end
  
  #フォロー機能
  
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follower
  
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :user
  
  def follow(user_id)
    return if self == user_id
    relationships.find_or_create_by!(follower_id: user_id)
  end
  
  def following?(user)
    followings.include?(user)
  end
  
  def unfollow(user_id)
    relationships.find_by(follower_id: user_id).destroy
  end
  
  #検索機能

  def self.search(keyword)
    where(["name like?", "%#{keyword}%"])
  end
  
  #コメント機能
  
  has_many :comments, dependent: :destroy
  
  
  
  validates :name, presence: true 
  validates :profile, length: { maximum: 200 }
  
end
