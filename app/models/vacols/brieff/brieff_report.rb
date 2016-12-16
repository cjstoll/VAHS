class Vacols::Brieff::BrieffReport
	attr_accessor  :result, :docdate

	def initialize(docdate, hType, rsType)
		@result = Vacols::Brieff.do_work(hType, rsType)
		@docdate = docdate
	end

	def get_pending_results
		ttlPending = 0
		output = Hash.new{|h, k| h[k] = Hash.new{|hh, kk| hh[kk] = [0,0,0,0,0,0]}}
		result.each do |i|
			output[i.get_regional_office]["fsclYear"][i.fiscal_year] +=1
			output[i.get_regional_office]["ttlPen"][0] += 1
			if(i.in_docdate(docdate))
				output[i.get_regional_office]["ttlPenDate"][0] += 1
				ttlPending +=1
			end
		end
		return output, ttlPending
	end
end