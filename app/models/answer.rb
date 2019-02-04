class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  has_many :user_answers, dependent: :nullify

  validates(
    :answer_body, 
    presence: {
      message: "Answer can not be empty!"
    }
  )

  validates(
    :correctness,
    inclusion: { in: [false, true] }
  )
end
