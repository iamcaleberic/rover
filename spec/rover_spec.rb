require 'rover'

describe "rover " do

	describe 'attributes' do
		# let is more clean for instance vars
		# before(:example) do 
		# 	@rover = Rover.new 
		# end
		# method call
		let(:rover) {Rover.new}

		it "Allows reading and writing for :make" do
			rover.make = "Test"
			expect(rover.make).to eq("Test")
		end

		it "Allows reading and writing for :year" do
			rover.year = 000
			expect(rover.year).to eq(000)
		end

		it "Allows reading and writing for :color" do
			rover.color = "Test"
			expect(rover.color).to eq("Test")
		end

		it "Allows reading and writing for :planet" do
			rover.make = "Test"
			expect(rover.make).to eq("Test")
		end

		it "Allows reading for :wheels" do
			expect(rover.wheels).to eq(4)
		end

		it "Allows writing of doors" 

		
	end

	describe '.colors' do 
		it "Returns an array of color names " do
			c =	['blue' , 'black' , 'red ' , 'green']
			expect(Rover.color).to match_array(c)
		end
	end

	describe '#full_name' do
		it "Returns a string in the expected format" do
			@mars = Rover.new(:make => "Mars Rover" , :year => 2016 , :color => "black" , :planet => 'mars')
			expect(@mars.full_name).to eq('Mars Rover 2016 (black) for travel on mars' )
		end

		context "When intialized with no arguments" do
			it "Returns a string using default values" do
				@rover  =  Rover.new
				expect(@rover.full_name).to eq("Calebs Rover 2139 (unknown) for travel on Caleb's planet")
			end
		end
	end


end