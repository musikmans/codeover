class ResultsController < ApplicationController
    def create
        @points = 0
        @total_points = 0
        params.permit(params)
        params.keys.each do |key|
            if key.include?("question")
                q_id = key.split("question")[1]
                param_obj = {
                    question_id: q_id,
                    answer_id: params[key],
                    quiz_id: params[:quiz_id],
                    user: current_user.id
                }
                UserAnswer.create(question_id: q_id, quiz_id: params[:quiz_id], answer_id: params[key], user: current_user)
                question = Question.find(q_id)
                answer_correctness = Answer.find(params[key])
                answer_correctness_value = answer_correctness.correctness 
                @total_points += question.points
                if answer_correctness_value == true
                    @points += question.points.to_i
                end
            end
        end

        user_score = Leaderboard.new(user_id: current_user.id, scores: @points, user_name: current_user.full_name )
        redirect_to results_path(iteration: params[:iteration], quiz_id: params[:quiz_id], points: @points, total_points: @total_points)
    end

    def index
        # byebug
        length_of_quiz = params[:iteration].to_i

        @points = params[:points]
        @total_points = params[:total_points]
        @result = (@points.to_i * 100)/@total_points.to_i

    end
end
