class Question < ApplicationRecord
  belongs_to :quiz
  belongs_to :user

  has_many :answers, dependent: :destroy

  validates(
    :body, 
    presence: {
      message: "Question body can't be empty"
    ,
    length: { minimum: 10 }
    }
  )

end
