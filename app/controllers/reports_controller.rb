class ReportsController < ApplicationController
  def home
    @docdate = params[:docdate]
	@hType = params[:hType]
	@rsType = params[:rsType]
  end

  def create
    @docdate = params[:docdate]+"-01"
	@hType = params[:hType]
	@rsType = params[:rsType]
	@shType = ""
	@ttlPending = 0
	
	case @hType
  	when "1"
  		@shType = "Central Office"
  	when "2"
		@shType = "Travel Board"
  	when "6"
  		@shType = "Video"
  	end
	
#is it faster to loop through @result twice or to add a check to each value in result
#but only loop through once?

	begin
		@result = Vacols::Brieff.do_work(@hType, @rsType)
		#@output = Hash.new {|h, k| h[k] = {:fsclYear =>[0,0,0,0,0,0,0], :ttlPenDate => {0}, :ttlPen =>{0}}
		#@output2 = Hash.new(fsclYear = (Hash.new([0,0,0,0,0])), (ttlPenDate = 0), (ttlePen = 0))
		@output = Hash.new{|h, k| h[k] = Hash.new{|hh, kk| hh[kk] = [0,0,0,0,0,0]}}
		@result.each do |i|
			@output[i["BFREGOFF"]]["fsclYear"][i.fiscal_year] +=1
			@output[i["BFREGOFF"]]["ttlPen"][0] += 1
			if(i.in_docdate(@docdate))
				@output[i["BFREGOFF"]]["ttlPenDate"][0] += 1
				@ttlPending +=1
			end
		end 
		if params[:ViewResults]
			@json = JSON.parse(@output.to_json)
		else
			@exportXLS = JSON.parse(@output.to_json)
		end
	end
	render :home
  end
end