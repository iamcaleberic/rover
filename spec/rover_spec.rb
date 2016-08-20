require 'rover'
require 'shared_examples/a_standard_space_auto'

describe Rover  do

	describe 'attributes' do
		# let is more clean for instance vars
		# before(:example) do 
		# 	@rover = Rover.new 
		# end
		# method call
		# let(:rover) {Rover.new}
		# subject {Rover.new}
		it_behaves_like('a standard space auto')
		
		it "allows reading and writing for :doors" do
			subject.door= 1
			expect(subject.door).to eq(1)
		end
	end

	describe '#initialize ' do 
		it "defaults to 4 doors" do
			expect(subject.door).to eq(4)
		end

		it "accepts an option for doors" do
			rover = Rover.new(:door => 1 )
			expect(rover.door).to eq(1)
		end 

		it "defaults to 4 if option is neither 2 or 4" do
			door_counts = []
			[0,1,3,5,6].each do |n|
				rover = Rover.new(:door => n)
				door_counts << rover.door
			end
			expect(door_counts).to all( eq(4) )
		end
	end

	describe '.colors' do 
		let(:colors) {['blue' , 'black' , 'red ' , 'green']}
		it "Returns an array of color names " do
			expect(Rover.color).to match_array(colors)
		end
	end

	describe '#full_name' do
		let(:mars) { Rover.new(:make => "Mars Rover" , :year => 2016 , :color => "black" , :planet => 'mars')}
		# if variable is subject
		let(:new_rover) { Rover.new }
		it "Returns a string in the expected format" do
			expect(mars.full_name).to eq('Mars Rover 2016 (black) for travel on mars' )
		end

		context "When intialized with no arguments" do
			it "Returns a string using default values" do
				expect(new_rover.full_name).to eq("Calebs Rover 2139 (unknown) for travel on Caleb's planet")
			end
		end
	end


end