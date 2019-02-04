class LeaderboardsController < ApplicationController

    def index
        @total_points_per_user = Leaderboard.select("sum(scores) as user_total_score").group("user_id").limit("10").order("user_total_score desc")
    end
end
