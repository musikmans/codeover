class ResultsController < ApplicationController
    def create

        arr = []
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
                # arr << param_obj
                UserAnswer.create(question_id: q_id, quiz_id: params[:quiz_id], answer_id: params[key], user: current_user)
            end
        end
        redirect_to results_path
    end

    def index
    
    end
end
