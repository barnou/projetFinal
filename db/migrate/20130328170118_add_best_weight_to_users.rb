class AddBestWeightToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :bestWeight, :decimal
  end

  def self.down
    remove_column :users, :bestWeight
  end
end
