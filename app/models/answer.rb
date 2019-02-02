class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates(
    :body, 
    presence: {
      message: "Answer can not be empty!"
    }
  )

  validates(
    :correctness,
    inclusion: {in: [true, false] }
  )
end
