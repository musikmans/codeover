class QuizzesController < ApplicationController
    before_action :find_quiz, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index]
    before_action :authorize_user!, only: [:edit, :update, :destroy]

    def new
        @quiz = Quiz.new
    end

    def create
        @quiz = Quiz.new quiz_params
        @quiz.user = current_user
        if @quiz.save
            flash[:primary] = "You have successfully created a new quiz, now create your set of questions."
            redirect_to new_quiz_question_path(@quiz.id)
        else
            flash[:danger] = "Opps, something went wrong!"
            render :new
        end
    end

    def index
        if params[:where_to] == "My quizzes"
            @quizzes = Quiz.where(:user_id => current_user.id).paginate(page: params[:page], per_page: 12)
        else 
            @quizzes = Quiz.paginate(page: params[:page], per_page: 12)
        end
    end

    def show
        @counter = 1
        @questions = @quiz.questions.order(created_at: :asc)
    end
    
    def edit
        @questions = @quiz.questions
        @question = Question.new
    end

    def update
        if @quiz.update quiz_params
            flash[:primary] = "Your quiz has been successfully updated!"
            redirect_to quizzes_path
          else
            flash[:danger] = "Oops, something went wrong!"
            render :edit
        end
    end

    def destroy
        @quiz.destroy
        flash[:danger] = "Quiz deleted successfully!"
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
        unless can?(:crud, @quiz)
          flash[:danger] = "Access Denied"
          redirect_to quizzes_path
        end
    end
end
