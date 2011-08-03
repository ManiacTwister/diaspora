class AddTimestampsToMentions < ActiveRecord::Migration
  def self.up
    add_column :mentions, :created_at, :timestamp
    add_column :mentions, :updated_at, :timestamp
  end

  def self.down
    remove_column :mentions, :created_at
    remove_column :mentions, :updated_at
  end
end
