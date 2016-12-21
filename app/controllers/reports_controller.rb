class ReportsController < ApplicationController
  def docket
    @docdate = params[:docdate]
	@hType = params[:hType]
	@rsType = params[:rsType]
  end
  def getDocket
    @docdate = params[:docdate]+"-01"
	@hType = params[:hType]
	@rsType = params[:rsType]
	@shType = ""
	@ttlbfDocDate = 0
	@ttls = {
		'fyCol' => [0,0,0,0,0,0],
		'ttlPending' => 0,
		'bfDocDate' => 0
	}
	
	case @hType
		when "1"
			@shType = "Central Office"
		when "2"
			@shType = "Travel Board"
		when "6"
			@shType = "Video"
  	end

		@output, @ttlbfDocDate = Vacols::Brieff.get_report(@docdate, @hType, @rsType)
		
		@doTtls = JSON.parse(@output.to_json)
		@doTtls.each do |roName,obj|
			@ttls["fyCol"][0] += obj["fyCol"][0]
			@ttls["fyCol"][1] += obj["fyCol"][1]
			@ttls["fyCol"][2] += obj["fyCol"][2]
			@ttls["fyCol"][3] += obj["fyCol"][3]
			@ttls["fyCol"][4] += obj["fyCol"][4]
			@ttls["fyCol"][5] += obj["fyCol"][5]
			@ttls["bfDocDate"] += obj["bfDocDate"]
			@ttls["ttlPending"] += obj["ttlPending"]
		end
		
		if params[:ViewResults]
			@json = JSON.parse(@output.to_json)
		else
			@exportXLS = JSON.parse(@output.to_json)
		end
	begin
	rescue
		@err = true
	end
	render :docket
  end

  def analysis
    @docdate = params[:docdate]
	@hType = params[:hType]
	@numJudge = params[:numJudge]
	@judgeMult = params[:judgeMult]
	@coDays = params[:coDays]  
  end
  def getAnalysis
    @docdate = params[:docdate]+"-01"
	@hType = params[:hType]
	@numJudge = params[:numJudge]
	@judgeMult = params[:judgeMult]
	@coDays = params[:coDays]  
	@judgeDays = 0
	@rsltHead ="<th class='cntrAlign'>TBD</th><th class='cntrAlign'>TBD</th><th class='cntrAlign'>TBD</th>"
	
	@shType = ""
	@ttlbfDocDate = 0
	
	@ttls = {
		'ttlPending' => 0,
		'bfDocDate' => 0,
		'ttlJudgeDays' => 0
	}
	
	case @hType
		when "1"
			@shType = "Central Office"
		when "2"
			@shType = "Travel Board"
		when "6"
			@shType = "Video"
			@judgeDays = ((((@numJudge.to_f * @judgeMult.to_f)) * 12)-12)-@coDays.to_i
			@rsltHead = "<th class='cntrAlign'>Judge Days Added</th><th class='cntrAlign'>Total Hearings Added</th><th class='cntrAlign'>Hearings Per Day<br/>(Based on TimeZone)</th>"
  	end

	begin
		
		@output, @ttlbfDocDate = Vacols::Brieff.get_report(@docdate, @hType, 0)

@output = eval("{'317 - St. Petersburg'=>{'fyCol'=>[1308, 0, 0, 0, 0, 0], 'ttlPending'=>3957, 'bfDocDate'=>1308},
'362 - Houston'=>{'fyCol'=>[1259, 0, 0, 0, 0, 0], 'ttlPending'=>3679, 'bfDocDate'=>1259},
'325 - Cleveland'=>{'fyCol'=>[922, 0, 0, 0, 0, 0], 'ttlPending'=>1330, 'bfDocDate'=>922},
'322 - Montgomery'=>{'fyCol'=>[871, 0, 0, 0, 0, 0], 'ttlPending'=>2359, 'bfDocDate'=>871},
'339 - Denver'=>{'fyCol'=>[845, 0, 0, 0, 0, 0], 'ttlPending'=>1595, 'bfDocDate'=>845},
'316 - Atlanta'=>{'fyCol'=>[758, 0, 0, 0, 0, 0], 'ttlPending'=>2030, 'bfDocDate'=>758},
'349 - Waco'=>{'fyCol'=>[732, 0, 0, 0, 0, 0], 'ttlPending'=>2229, 'bfDocDate'=>732},
'377 - San Diego'=>{'fyCol'=>[588, 0, 0, 0, 0, 0], 'ttlPending'=>1678, 'bfDocDate'=>588},
'343 - Oakland'=>{'fyCol'=>[542, 0, 0, 0, 0, 0], 'ttlPending'=>1286, 'bfDocDate'=>542},
'318 - Winston-Salem'=>{'fyCol'=>[531, 0, 0, 0, 0, 0], 'ttlPending'=>2342, 'bfDocDate'=>531},
'320 - Nashville'=>{'fyCol'=>[507, 0, 0, 0, 0, 0], 'ttlPending'=>1323, 'bfDocDate'=>507},
'329 - Detroit'=>{'fyCol'=>[476, 0, 0, 0, 0, 0], 'ttlPending'=>1827, 'bfDocDate'=>476},
'319 - Columbia'=>{'fyCol'=>[465, 0, 0, 0, 0, 0], 'ttlPending'=>1108, 'bfDocDate'=>465},
'348 - Portland'=>{'fyCol'=>[449, 0, 0, 0, 0, 0], 'ttlPending'=>1219, 'bfDocDate'=>449},
'345 - Phoenix'=>{'fyCol'=>[441, 0, 0, 0, 0, 0], 'ttlPending'=>1098, 'bfDocDate'=>441},
'346 - Seattle'=>{'fyCol'=>[341, 0, 0, 0, 0, 0], 'ttlPending'=>822, 'bfDocDate'=>341},
'323 - Jackson'=>{'fyCol'=>[307, 0, 0, 0, 0, 0], 'ttlPending'=>726, 'bfDocDate'=>307},
'328 - Chicago'=>{'fyCol'=>[289, 0, 0, 0, 0, 0], 'ttlPending'=>746, 'bfDocDate'=>289},
'351 - Muskogee'=>{'fyCol'=>[288, 0, 0, 0, 0, 0], 'ttlPending'=>1665, 'bfDocDate'=>288},
'326 - Indianapolis'=>{'fyCol'=>[283, 0, 0, 0, 0, 0], 'ttlPending'=>616, 'bfDocDate'=>283},
'314 - Roanoke'=>{'fyCol'=>[279, 0, 0, 0, 0, 0], 'ttlPending'=>649, 'bfDocDate'=>279},
'344 - Los Angeles'=>{'fyCol'=>[267, 0, 0, 0, 0, 0], 'ttlPending'=>1072, 'bfDocDate'=>267},
'301 - Boston'=>{'fyCol'=>[228, 0, 0, 0, 0, 0], 'ttlPending'=>859, 'bfDocDate'=>228},
'310 - Philadelphia'=>{'fyCol'=>[215, 0, 0, 0, 0, 0], 'ttlPending'=>1142, 'bfDocDate'=>215},
'315 - Huntington'=>{'fyCol'=>[214, 0, 0, 0, 0, 0], 'ttlPending'=>990, 'bfDocDate'=>214},
'330 - Milwaukee'=>{'fyCol'=>[210, 0, 0, 0, 0, 0], 'ttlPending'=>640, 'bfDocDate'=>210},
'321 - New Orleans'=>{'fyCol'=>[172, 0, 0, 0, 0, 0], 'ttlPending'=>822, 'bfDocDate'=>172},
'350 - Little Rock'=>{'fyCol'=>[169, 0, 0, 0, 0, 0], 'ttlPending'=>641, 'bfDocDate'=>169},
'331 - St. Louis'=>{'fyCol'=>[156, 0, 0, 0, 0, 0], 'ttlPending'=>551, 'bfDocDate'=>156},
'340 - Albuquerque'=>{'fyCol'=>[134, 0, 0, 0, 0, 0], 'ttlPending'=>647, 'bfDocDate'=>134},
'309 - Newark'=>{'fyCol'=>[123, 0, 0, 0, 0, 0], 'ttlPending'=>725, 'bfDocDate'=>123},
'327 - Louisville'=>{'fyCol'=>[120, 0, 0, 0, 0, 0], 'ttlPending'=>405, 'bfDocDate'=>120},
'333 - Des Moines'=>{'fyCol'=>[99, 0, 0, 0, 0, 0], 'ttlPending'=>567, 'bfDocDate'=>99},
'307 - Buffalo'=>{'fyCol'=>[97, 0, 0, 0, 0, 0], 'ttlPending'=>488, 'bfDocDate'=>97},
'335 - St. Paul'=>{'fyCol'=>[66, 0, 0, 0, 0, 0], 'ttlPending'=>760, 'bfDocDate'=>66},
'306 - New York'=>{'fyCol'=>[45, 0, 0, 0, 0, 0], 'ttlPending'=>462, 'bfDocDate'=>45},
'355 - San Juan'=>{'fyCol'=>[45, 0, 0, 0, 0, 0], 'ttlPending'=>260, 'bfDocDate'=>45},
'459 - Honolulu'=>{'fyCol'=>[40, 0, 0, 0, 0, 0], 'ttlPending'=>184, 'bfDocDate'=>40},
'311 - Pittsburgh'=>{'fyCol'=>[40, 0, 0, 0, 0, 0], 'ttlPending'=>146, 'bfDocDate'=>40},
'347 - Boise'=>{'fyCol'=>[34, 0, 0, 0, 0, 0], 'ttlPending'=>293, 'bfDocDate'=>34},
'313 - Baltimore'=>{'fyCol'=>[30, 0, 0, 0, 0, 0], 'ttlPending'=>70, 'bfDocDate'=>30},
'452 - Wichita'=>{'fyCol'=>[20, 0, 0, 0, 0, 0], 'ttlPending'=>278, 'bfDocDate'=>20},
'354 - Reno'=>{'fyCol'=>[19, 0, 0, 0, 0, 0], 'ttlPending'=>297, 'bfDocDate'=>19},
'334 - Lincoln'=>{'fyCol'=>[17, 0, 0, 0, 0, 0], 'ttlPending'=>485, 'bfDocDate'=>17},
'460 - Wilmington'=>{'fyCol'=>[16, 0, 0, 0, 0, 0], 'ttlPending'=>34, 'bfDocDate'=>16},
'308 - Hartford'=>{'fyCol'=>[13, 0, 0, 0, 0, 0], 'ttlPending'=>254, 'bfDocDate'=>13},
'402 - Togus'=>{'fyCol'=>[10, 0, 0, 0, 0, 0], 'ttlPending'=>73, 'bfDocDate'=>10},
'442 - Cheyenne'=>{'fyCol'=>[9, 0, 0, 0, 0, 0], 'ttlPending'=>59, 'bfDocDate'=>9},
'304 - Providence'=>{'fyCol'=>[7, 0, 0, 0, 0, 0], 'ttlPending'=>333, 'bfDocDate'=>7},
'438 - Sioux Falls'=>{'fyCol'=>[7, 0, 0, 0, 0, 0], 'ttlPending'=>156, 'bfDocDate'=>7},
'358 - Manila'=>{'fyCol'=>[7, 0, 0, 0, 0, 0], 'ttlPending'=>43, 'bfDocDate'=>7},
'363 - Anchorage'=>{'fyCol'=>[5, 0, 0, 0, 0, 0], 'ttlPending'=>103, 'bfDocDate'=>5},
'436 - Ft. Harrison'=>{'fyCol'=>[4, 0, 0, 0, 0, 0], 'ttlPending'=>63, 'bfDocDate'=>4},
'437 - Fargo'=>{'fyCol'=>[4, 0, 0, 0, 0, 0], 'ttlPending'=>83, 'bfDocDate'=>4},
'341 - Salt Lake City'=>{'fyCol'=>[3, 0, 0, 0, 0, 0], 'ttlPending'=>305, 'bfDocDate'=>3},
'373 - Manchester'=>{'fyCol'=>[2, 0, 0, 0, 0, 0], 'ttlPending'=>108, 'bfDocDate'=>2},
'405 - White River Juncti'=>{'fyCol'=>[2, 0, 0, 0, 0, 0], 'ttlPending'=>36, 'bfDocDate'=>2}}")
		@ttlbfDocDate = 15130

		@doTtls = JSON.parse(@output.to_json)
		@doTtls.each do |roName,obj|
			@ttls["bfDocDate"] += obj["bfDocDate"]
			@ttls["ttlPending"] += obj["ttlPending"]
		end
		
		if params[:ViewResults]
			@json = JSON.parse(@output.to_json)
		else
			@exportXLS = @json
			
		end
	rescue
		@err = true
	end

    render :analysis
	end
end