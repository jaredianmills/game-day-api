class AddBoardgameIdToBoardgames < ActiveRecord::Migration[5.2]
  def change
    add_column :boardgames, :boardgame_id, :string
  end
end
