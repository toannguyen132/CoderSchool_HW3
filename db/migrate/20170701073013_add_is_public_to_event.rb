class AddIsPublicToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :is_public, :bool
  end
end
