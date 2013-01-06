class Campaign < ActiveRecord::Base
  attr_accessible :category, :type, :group_name, :name, :city, :state, 
  :one_sentence, :long_description, :youtube_link, :vimeo_link, 
  :vimeo_video_id, :youtube_video_id, :request, :end_date, :active, :image

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  belongs_to :user

  has_many :gifts

  validates :user_id, presence: true, uniqueness: true

  before_save :create_video_id_for_youtube if :youtube_link_changed?

  before_save :create_video_id_for_vimeo if :vimeo_link_changed?

  def create_video_id_for_youtube
  	self.youtube_video_id = self.youtube_link.gsub("http://youtu.be/", "")
  end

  def create_video_id_for_vimeo
  	self.vimeo_video_id = self.vimeo_link.gsub("http://vimeo.com/", "")
  end

end
