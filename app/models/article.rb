# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
  #記事のアイキャッチ
  has_one_attached :eyecatch
  has_rich_text :content

  # バリデーションを追加

  # length文字の長さ
  # titleに先頭に＠がついたらNGのvalidates

  # length文字の長さ
  # uniqueness 同じ文章はNGのValidation
  validates :title, presence: true
  validates :title, length: { minimum: 2, maximum: 100 }
  validates :title, format: { with: /\A(?!\@)/ }
  
  validates :content, presence: true

  
  #記事articlesから見たらuserは1つ
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  
  # 投稿日を日本語化
  def display_created_at
    I18n.l(created_at, format: :default)
  end

  def author_name
    user.display_name
  end

  def like_count
    likes.count
  end
  
end
