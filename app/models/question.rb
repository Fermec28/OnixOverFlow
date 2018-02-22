class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, :as => :commentable, dependent: :destroy
  has_many :votes, :as => :votable, dependent: :destroy

  validates :title, presence: true, allow_blank: false
  validates :question, presence: true, allow_blank: false
end
