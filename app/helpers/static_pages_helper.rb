module StaticPagesHelper
	require 'date'

	def day_off?(dow)
    	["FRIDAY", "SATURDAY", "SUNDAY"].include?(dow)
  	end

  	def today
  		return DateTime.now.strftime('%A').upcase
  	end

  	def dft(dft)
  		DateTime.now.next_day(dft).strftime('%A').upcase
  	end
end
