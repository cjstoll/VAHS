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
	@ttlbfDocDate = 0
	
	case @hType
  	when "1"
  		@shType = "Central Office"
  	when "2"
		@shType = "Travel Board"
  	when "6"
  		@shType = "Video"
  	end

		@output, @ttlbfDocDate = Vacols::Brieff.get_report(@docdate, @hType, @rsType)

		if params[:ViewResults]
			@json = JSON.parse(@output.to_json)
		else
			@exportXLS = JSON.parse(@output.to_json)
		end
	begin
	rescue
		@err = true
	end
	render :home
  end
end