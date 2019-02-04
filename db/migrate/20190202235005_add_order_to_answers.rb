class AddOrderToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column(:answers, :order, :integer)
  end
end
