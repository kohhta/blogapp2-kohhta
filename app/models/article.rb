# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text             not null
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
  # バリデーションを追加

  # length文字の長さ
  # titleに先頭に＠がついたらNGのvalidates

  # length文字の長さ
  # uniqueness 同じ文章はNGのValidation
  validates :title, presence: true
  validates :title, length: { minimum: 2, maximum: 100 }
  validates :title, format: { with: /\A(?!\@)/ }
  
  validates :content, presence: true
  validates :content, length: { minimum: 2 }
  validates :content, uniqueness: true
  
  # 自分に作ったvalidates,titleとcontentの文字数合計
  validate :validate_title_and_content_length


  
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
  
  

  private

  def validate_title_and_content_length
    word_count = title.length + content.length
    errors.add(:content, '5文字以上にしてください！！') unless word_count > 5
  end
end
