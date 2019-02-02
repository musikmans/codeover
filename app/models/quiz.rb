class Quiz < ApplicationRecord
  belongs_to :user

  has_many :questions, dependent: :destroy

  validates(
    :name,
    presence: {
      message: "The quiz name can't be empty"
    },
    length: {
      minimum: 3
    }
  )

  validates(
    :description,
    presence: {
      message: "Please enter a brief description for the quiz"
    },
    length: {
      minimum: 10
    }
  )
end
