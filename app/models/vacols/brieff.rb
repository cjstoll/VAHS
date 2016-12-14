class Vacols::Brieff < Vacols::Record
  self.table_name = "BRIEFF"
  
  def self.form_completed
    where.not(:BFD19 => nil)
  end

  def self.check_action
    where("BFHA = 3 OR BFHA IS NULL")
  end

  def self.is_advanced
    where(:BFMPRO => 'ADV')
  end

  def self.is_remanded
    where(:BFMPRO => 'REM')
  end

  def self.limit_docdate(docdate)
  	where("BFD19 < ?", docdate)
  end

  def self.new_tb_request
    where("BFDTB > BFDDEC")
  end

  def self.tb_request
    where.not(:BFDTB => nil)
  end

  def self.check_pending2
    is_remanded.tb_request.new_tb_request
  end

  #needs to also check the commented line but cannot get the OR working correctly
  def self.check_pending(docdate)
    #a = is_remanded.tb_request.new_tb_request.limit_docdate(docdate)
    form_completed.check_action.is_advanced.limit_docdate(docdate)
  end

  def self.travel_board(docdate)
  	check_pending(docdate).where(:BFHR => 2)
  end

  def self.central_office(docdate)
    check_pending(docdate).where(:BFHR => 1, :BFDOCIND => 'N')
  end

  def self.video(docdate)
  	check_pending(docdate).where(:BFHR => 1,:BFDOCIND => 'Y')
  end


  def fiscal_year
	temp = Date.new(2000, 9, 30)
	case
	when (self.BFD19 <= temp)
	  0
	when (self.BFD19 <= temp + 5.years)
	  1
	when (self.BFD19 <= temp + 10.years)
	  2
	when (self.BFD19 <= temp + 15.years)
	  3
	when (self.BFD19 <= temp + 16.years)
	  4
	when (self.BFD19 <= temp + 17.years)
	  5
	else
	  puts "error"
	end
  end 


  def self.do_work(docdate, hType, rsType)
  	case hType
  	when "1"
  		central_office(docdate)
  	when "2"
  		travel_board(docdate)
  	when "6"
  		video(docdate)
  	when 0
  		limit_docdate(docdate)
  	else
  		puts "error"
  	end
  end
end