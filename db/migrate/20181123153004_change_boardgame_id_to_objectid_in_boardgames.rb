class ChangeBoardgameIdToObjectidInBoardgames < ActiveRecord::Migration[5.2]
  def change
    rename_column :boardgames, :boardgame_id, :objectid
  end
end
