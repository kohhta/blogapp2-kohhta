# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Article < ApplicationRecord
  # バリデーションを追加
  validates :title, presence: true
  # length文字の長さ
  validates :title, length: { minimum: 2, maximum: 100 }
  # titleに先頭に＠がついたらNGのvalidates
  validates :title, format: { with: /\A(?!\@)/ }

  validates :content, presence: true
  # length文字の長さ
  validates :content, length: { minimum: 2 }
  # uniqueness 同じ文章はNGのValidation
  validates :content, uniqueness: true

  # 自分に作ったvalidates,titleとcontentの文字数合計
  validate :validate_title_and_content_length

  # 投稿日を日本語化
  def display_created_at
    I18n.l(created_at, format: :default)
  end

  private

  def validate_title_and_content_length
    word_count = title.length + content.length
    errors.add(:content, '5文字以上にしてください！！') unless word_count > 5
  end
end
