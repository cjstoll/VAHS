class Vacols::Brieff < Vacols::Record
  self.table_name = "BRIEFF"
  
  def self.limit_docdate(docdate)
  	where("BFD19 < ?", docdate)
  end

  def self.travel_board(docdate)
  	limit_docdate(docdate).where(:BFHR => 2)
  end

  def self.central_office(docdate)
  limit_docdate(docdate).where(:BFHR => 1, :BFDOCIND => 'N')
  end

  def self.video(docdate)
  	limit_docdate(docdate).where(:BFHR => 1,:BFDOCIND => 'Y')
  end


  def fiscal_year
	begin
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
	rescue
		puts "error"
	end
  end 


  def self.do_work(docdate, hType, rsType)
	begin
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
	rescue
		puts "error"
	end
  end
end