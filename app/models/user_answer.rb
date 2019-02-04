class UserAnswer < ApplicationRecord
  belongs_to :quiz
  belongs_to :question
  belongs_to :answer
  belongs_to :user

  validates(
    :quiz_id,
    presence: true
  )

  validates(
    :question_id,
    presence: true
  )

  validates(
    :answer_id,
    presence: true
  )

  validates(
    :user_id,
    presence: true
  )
end
