class AddUsersToLeaderboard < ActiveRecord::Migration[5.2]
  def change
    add_column(:leaderboards, :user_name, :string)
  end
end
