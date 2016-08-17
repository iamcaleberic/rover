class Raptor
	attr_accessor :make , :year , :color , :planet
	attr_reader :wheels
	attr_writer :door

	def initialize(options={})
		self.make = options[:make] || "Hell Raptor"
		self.year = (options[:year] || 2150).to_i
		self.color = options[:color] || "Onfire" 
		self.planet = options[:planet] || "Kresh planet"
		@wheels = 4
	end

	def self.color
		['blue' , 'black' , 'red ' , 'green']
	end

	def full_name
		"#{self.make} #{self.year.to_s} (#{self.color}) for travel on #{self.planet}"
	end
end