class QuestionsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_question, only: [:update, :destroy]
    before_action :authorize_user!, only: [:update, :destroy]

    def new 
        @question = Question.new
        @quiz = Quiz.find(params[:quiz_id])
    end

    def create 
        @question = Question.new(body: params[:question][:body], points: params[:question][:points], user: current_user, quiz_id: params[:quiz_id])
        @question.save!
        Answer.create(question_id: @question.id, answer_body: params[:question][:answer_body_1], user_id: current_user, correctness: true, order: 1)
        Answer.create(question_id: @question.id, answer_body: params[:question][:answer_body_2], user_id: current_user, order: 2)
        Answer.create(question_id: @question.id, answer_body: params[:question][:answer_body_3], user_id: current_user, order: 3)
        Answer.create(question_id: @question.id, answer_body: params[:question][:answer_body_4], user_id: current_user, order: 4)

        if @question.save
            redirect_to new_quiz_question_path(params[:quiz_id])
            flash[:primary] = "Question was created successfully!"
        else
            render :new
            flash[:danger] = "Oops, Something went wrong, question wasn't created!"
        end
    end

    def update
       if @question.update question_params
        redirect_to edit_quiz_path(@quiz.id)
        flash[:primary] = "The question has been updated"
       else
        render quizzes_path(@quiz)
        flash[:danger] = "Oops something went wrong, the question hasn't been updated.."
       end
    end

    def destroy
        @question.destroy
        redirect_to quizzes_path(@quiz)
    end

    private
    def question_params
        params.require(:question).permit(:body, :points, :answer_body_1, :answer_body_2, :answer_body_3, :answer_body_4)
    end

    def find_question
        @question = Question.find params[:id]
        @quiz = @question.quiz
    end

    def authorize_user!
        unless can?(:crud, @question)
            flash[:danger] = "Access Denied"
            redirect_to root_path
        end
    end
end
