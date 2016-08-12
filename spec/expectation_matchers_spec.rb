describe 'Expectation Matchers' do 

	describe 'equivalence matchers' do 

		it 'Will match loose equality with #eq' do 
			a = "2 jets"
			b = "2 jets"

			expect(a).to eq(b)
			expect(a).to be == b


			c = 16
			d = 16.0
			expect(c).to eq(d)  #different types, but "Close enough"
		end


		it "Will match value equality with #eql" do
			a = "2 rovers"
			b = "2 rovers"
			expect(a).to eql(b) #A bit stricter
		
			c = 16
			d = 16.0

			expect(c).not_to equal(d)  # close dont count has to be equal


		end

		it "will match identity equality with #equal" do
			a =  '2 planets'
			b =  '2 planets'

			expect(a).not_to equal(b) # same value diff object
		
			c = b 
			expect(b).to equal(c) #same object
			expect(b).to be(c) # #equal synonym

		end
	end


	describe "truthiness matchers" do 

		it "will match true/false" do

			expect(2 < 4).to be(true) 
			expect(2 > 4).to be(false)

			expect('foo').not_to be(true)
			expect(nil).not_to be(false)

			expect(0).not_to be(false)

		end

		it "will match truthy/falsey" do

			expect(2 < 4).to be_truthy
			expect(2 > 4).to be_falsey

			expect('foo').to be_truthy

			expect(nil).to be_falsey
			expect(0).not_to be_falsey
		end

		it "will match nil " do 

			expect(nil).to be_nil
			expect(nil).to be(nil)

			expect(false).not_to be_nil

			expect(0).not_to be_nil
		end
	end


	describe "numeric comparison matchers" do

		it "will match less than/greater than" do

			expect(10).to be > 9
			expect(10).to be >= 10
			expect(10).to be <= 10
			expect(9).to be < 10 
		end

		it "will match numeric ranges" do

			expect(10).to be_between(5 , 20).inclusive
			expect(20).not_to be_between(5 , 20).exclusive
			expect(10).to be_within(1).of(11)
			expect(5..10).to cover(9)
		end

	end
end