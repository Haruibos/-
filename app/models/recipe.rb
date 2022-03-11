class Recipe < ApplicationRecord
  belongs_to :user
  attachment :image

  has_many :ingredients, dependent: :destroy
  
  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :ingredients, :orders, allow_destroy: true
  
  has_many :comments, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags
  has_many :favorites, dependent: :destroy

  validates :name, presence: true
  validates :image, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
  
  scope :latast_recipes_per_8, -> { reverse_order.per(8) }
  # お作法、railsの深いところ
  # 1ページに表示されるレシピ個数

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  
end