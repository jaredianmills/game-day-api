class AddBoardgameIdToCollection < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :boardgame_id, :string
  end
end
