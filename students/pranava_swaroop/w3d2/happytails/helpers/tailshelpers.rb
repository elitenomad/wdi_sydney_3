module HappyTailhelpers
	def diff_time_in_days(donated_at)
		current_time = Time.now
		(current_time.to_date - ((donated_at)).to_date)
	end
end