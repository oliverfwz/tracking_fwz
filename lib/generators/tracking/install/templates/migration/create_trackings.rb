class CreateTrackings < ActiveRecord::Migration
  def self.up
    create_table :trackings do |t|
      t.text     "history"
      t.string   "ip_address"
      t.string   "user_email"
      t.timestamps
    end
  end

  def self.down
    drop_table :trackings
  end
end