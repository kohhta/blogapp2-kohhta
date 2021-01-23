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
  #length文字の長さ
  validates :title, length: { minimum: 2, maximum: 100 }

  validates :content, presence: true
  #length文字の長さ
  validates :content, length: { minimum: 2 }
  #uniqueness 同じ文章はNGのValidation
  validates :content, uniqueness: true

  # 投稿日を日本語化
  def display_created_at
    I18n.l(created_at, format: :default)
  end
end
