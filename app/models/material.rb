class Material < ActiveRecord::Base
	
	belongs_to :subject

	default_scope -> { order('created_at ASC') }
	validates :name, presence: true, length: { maximum: 70, too_long: "too long!" }
	VALID_LINK_REGEX = /\A(|https?:\/\/[a-zA-Z0-9\-_\.:@]+(\/?|\/[a-zA-Z0-9\-_\.!~*'\(\);\?:@&=\+$,%#\/]*))\z/
	validates :link, format: { with: VALID_LINK_REGEX }
end