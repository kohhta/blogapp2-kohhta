# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  #Userは記事コメントlikeを沢山もっている,消えたら一緒にarticles消える
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  #likeしたarticleだけ取得
  has_many :favorite_articles, through: :likes, source: :article

  has_one :profile,dependent: :destroy

  delegate :birthday, :gender, :age, to: :profile, allow_nil: true

  # Userが書いた記事だけ表示
  def has_written?(article)
    articles.exists?(id: article.id)
  end

  # likeしたarticle_idはあるか?のメソッド
  def has_liked?(article)
    likes.exists?(article_id: article.id)
  end
  

  #userのemail先頭をdisplay_nameに
  def display_name
    # if profile && profile.nickname
    #   profile.nickname
    # else
    #   self.email.split('@').first
    # end

    # ぼっち演算子 &. nillじゃない場合だけ実行
    profile&.nickname || self.email.split('@').first
  end

  # def birthday 
  #   profile&.birthday
  # end

  # def gender
  #   profile&.gender
  # end
  
    #profile_controllerのedit
    def prepare_profile
      profile || build_profile
    end

    def avatar_image
      if profile&.avatar&.attached? 
        profile.avatar 
      else
        'default-avatar.png'
      end
    end
    
end