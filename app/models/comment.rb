class Comment < ActiveRecord::Base

	belongs_to :subject
	default_scope -> { order('created_at DESC') }

end