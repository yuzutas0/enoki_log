class Subject < ActiveRecord::Base

	belongs_to :user
	has_many :materials, dependent: :destroy
	accepts_nested_attributes_for :materials, :reject_if => lambda { |a| a[:name].blank? }, allow_destroy: true
	has_many :diaries, dependent: :destroy
	accepts_nested_attributes_for :diaries
	has_many :comments, dependent: :destroy

	default_scope -> { order('created_at DESC') }
	VALID_URL_REGEX = /\A[0-9a-f]{12}\z/
	
	validates :title, presence: true, length: { maximum: 70, too_long: "too long!" }
	validates :description, length: { maximum: 5000, too_long: "too long!" }
	validates :start_day, presence: true
	validates :end_day, presence: true
	validates :user_id, presence: true
	validates :url, presence: true, format: { with: VALID_URL_REGEX }

	validate :day_check

	private
		def day_check
			errors.add(:end_day, "") unless self.start_day < self.end_day
		end

end
