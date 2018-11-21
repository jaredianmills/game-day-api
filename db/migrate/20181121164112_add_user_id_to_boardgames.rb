class AddUserIdToBoardgames < ActiveRecord::Migration[5.2]
  def change
    add_column :boardgames, :user_id, :integer
  end
end
