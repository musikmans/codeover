class RenameBodyFromAnswerToAnswerBody < ActiveRecord::Migration[5.2]
  def change
    rename_column :answers, :body, :answer_body
  end
end
