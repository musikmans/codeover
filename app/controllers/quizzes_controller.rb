class QuizzesController < ApplicationController
    # before_action: 

    def new

    end

    def create

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
    def quiz_params
        params.require(:quiz).permit(:name, :description)
    end

    def find_quiz
        @quiz = Quiz.find params[:id]
    end

end
