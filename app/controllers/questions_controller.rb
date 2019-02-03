class QuestionsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_quiz, only: [:update, :destroy]
    before_action :authorize_user!, only: [:update, :destroy]

    def new 
        @question = Question.new
    end

    def create 
        @question = Question.new question_params
        @question.save!
        @question.answer = Answer.new(question_id: @question.id, answer_body: params[:answer_body_1], user_id: current_user, correctness: true, order: 1)
        @question.answer.save!
        @question.answer = Answer.new(question_id: @question.id, answer_body: params[:answer_body_2], user_id: current_user, order: 2)
        @question.answer.save!
        @question.answer = Answer.new(question_id: @question.id, answer_body: params[:answer_body_3], user_id: current_user, order: 3)
        @question.answer.save!
        @question.answer = Answer.new(question_id: @question.id, answer_body: params[:answer_body_4], user_id: current_user, order: 4)
        @question.answer.save!

        
    end

    def update
       if @question.update question_params
        flash[:primary] = "The question has been updated"
            redirect_to quizzes_path(@quiz)
       else
        flash[:danger] = "Oops something went wrong, the question hasn't been updated.."
        render quizzes_path(@quiz)
       end
    end
x

    def destroy
        @question.destroy
        redirect_to quizzes_path(@quiz)
    end

    private
    def question_params
        params.require(:question).permit(:body, :points, :answer_body_1, :answer_body_2, :answer_body_3, :answer_body_4)
    end

    def find_question
        @quiz = Quiz.find params[:id]
    end

    def authorize_user!
        unless can?(:crud, @question)
            flash[:danger] = "Access Denied"
            redirect_to root_path
        end
    end
end
