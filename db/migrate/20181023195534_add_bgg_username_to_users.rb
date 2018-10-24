class AddBggUsernameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bgg_username, :string, default: nil
  end
end
