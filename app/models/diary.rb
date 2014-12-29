class Diary < ActiveRecord::Base

	belongs_to :subject
	default_scope -> { order('created_at ASC') }
	# progressフィールドは進捗に応じて0以上〜100以下の値を取る
		# 当面は10 ×、50 △・100 ○、150 ◎の4段評価（文字コード問題に注意）
end

