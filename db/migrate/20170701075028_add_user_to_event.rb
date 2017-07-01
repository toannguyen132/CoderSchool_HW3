class AddUserToEvent < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :user, foreign_key: true
    change_column :events, :is_public, :boolean, default: false
  end
end
