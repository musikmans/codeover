class QuizzesController < ApplicationController
    before_action :find_quiz, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only: [:edit, :update, :destroy]

    def new
        @quiz = Quiz.new
    end

    def create
        @quiz = Quiz.new quiz_params
        @quiz.user = current_user
        if @quiz.save
            redirect_to quiz_path(@quiz.id)
        else
            render :new
        end
    end

    def index
        @questions = Question.all
    end

    def show
        @questions = @quiz.questions.order(created_at: :desc)
        @question = Question.new
    end

Q  def edit

    end

    def update
        if @quiz.update quiz_params
            redirect_to quiz_path(@quiz.id)
          else
            render :edit
        end
    end

    def destroy
        @quiz.destroy
        redirect_to quizzes_path
    end

    private
    def quiz_params
        params.require(:quiz).permit(:name, :description)
    end

    def find_quiz
        @quiz = Quiz.find params[:id]
    end
    def authorize_user!
        
        unless can?(:crud, @question)
          flash[:danger] = "Access Denied"
          redirect_to question_path(@question)
        end
      end
end
