class QuestionsController < ApplicationController
    before_action :find_question, only: [:show, :edit, :update, :destroy]

    def new
        # @question = Question.new
    end

    def create
        @question = Question.new question_params
        @question.user = current_user
        @question.quiz = Quiz.find params[:id]
        

        if @question.save
            redirect_to 
        else
            render :new
        end
    end

    def index

    end

    def show

    end

    def edit

    end

    def update

    end

    def destroy

    end

    private
    def question_params
        params.require(:question).permit(:body, :points)
    end

    def find_question
        @question = Question.find params[:id]
    end
end
