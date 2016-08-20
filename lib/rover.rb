class Rover
	attr_accessor :make , :year , :color , :planet
	attr_reader :wheels
	attr_accessor :door

	def initialize(options={})
		self.make   =  options[:make]     || "Calebs Rover"
		self.year   =  (options[:year]    || 2139).to_i
		self.color  =  options[:color]    || "unknown" 
		self.planet =  options[:planet]   || "Caleb's planet"
		self.door   =  options[:door]     || 4
		self.door = 4 unless [2,4].include?(door)
		@wheels = 4
	end

	def self.color
		['blue' , 'black' , 'red ' , 'green']
	end

	def full_name
		"#{self.make} #{self.year.to_s} (#{self.color}) for travel on #{self.planet}"
	end

	def onmoon?
		door == 2

	end

	def offmoon?
		door == 4
	end
end