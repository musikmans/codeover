class AnswersController < ApplicationController

    def update 
        @question = Question.find params[:question_id]
        @quiz = @question.quiz
        @answer = Answer.find params[:id]
        if @answer.update answer_params 
            flash[:primary] = "Answer has been updated"
            redirect_to edit_quiz_question_path(@quiz, @question)
        else
            flash[:danger] = "Oops something went wrong"
            redirect_to edit_quiz_question_path(@quiz, @question)
        end
    end 


    private 

    def answer_params 
        params.require(:answer).permit(:answer_body)
    end
end
