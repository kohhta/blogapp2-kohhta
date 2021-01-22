class Article < ApplicationRecord
  # バリデーションを追加
  validates :title, presence: true
  validates :content, presence: true

  # 投稿日を日本語化
  def display_created_at
    I18n.l(self.created_at, format: :default)
  end

end