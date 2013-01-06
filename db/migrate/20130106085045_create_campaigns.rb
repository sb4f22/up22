class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.integer :user_id
      t.string :category
      t.string :type
      t.string :group_name
      t.string :name
      t.string :city
      t.string :state
      t.string :one_sentence
      t.string :long_description
      t.string :youtube_link
      t.string :vimeo_link
      t.string :youtube_video_id
      t.string :vimeo_video_id
      t.decimal :request
      t.date :end_date
      t.boolean :active, default: false
      t.timestamps
    end
      add_index :campaigns,:category
      add_index :campaigns,:type
      add_index :campaigns,:group_name
      add_index :campaigns,:name
      add_index :campaigns,:city
      add_index :campaigns,:state
      add_index :campaigns,:active
      add_index :campaigns,:end_date
  end

  def self.down
    drop_table :campaigns
  end

end