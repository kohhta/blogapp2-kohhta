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
  validates :content, presence: true

  # 投稿日を日本語化
  def display_created_at
    I18n.l(created_at, format: :default)
  end
end
