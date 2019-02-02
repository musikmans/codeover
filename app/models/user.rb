class User < ApplicationRecord
    has_many :questions, dependent: :nullify
    has_many :answers, dependent: :nullify
    has_many :quizzes, dependent: :nullify

    validates(
        :email,
        uniquness: true,
        presence: {
            message: "Please enter an email!"
        },
        format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i 
    )

    def full_name
        "#{first_name} #{last_name}".strip 
    end
    
end
