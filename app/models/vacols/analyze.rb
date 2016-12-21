class Vacols::Analyze
attr_accessor  :numJudge, :judgeMult, :coDays, :docketReport,:ttlbfDocDate, :judgeDays


#where does the missing 9 days go in his calculations?
#1536(me) vs 1527(him)?  2.25x57x12 = 1539?  much confuse
#I"m sure its cause of casting. Will do a better way later?
	def initialize(numJudge, judgeMult, coDays, docketReport, ttlbfDocDate)
		@numJudge = numJudge.to_f
		@judgeMult = judgeMult.to_f
		@coDays = coDays.to_i
		@docketReport = docketReport
		@ttlbfDocDate = ttlbfDocDate.to_f
		@judgeDays = ((@numJudge * @judgeMult)).to_i * 12 - 9 #why??????
	end

	def allocate_video_hearings
		max = @judgeDays - @coDays
		remaining = max
		output = Hash.new { |hash, key| hash[key] = 0 }
		@docketReport.each do |k, v|
			requestDays = (((v["bfDocDate"].to_f/@ttlbfDocDate)*100).round(4) * max).to_i
			while((remaining > 0) & (requestDays > 0))
				byebug
				output[k] += 1
				requestDays -= 1
				remaining -= 1
			end
			if(remaining <= 0)
				break
			end
		end
		return output
	end
end