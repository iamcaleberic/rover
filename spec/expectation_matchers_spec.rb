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

	describe "collection matchers" do
		it "Wil match arrays" do
			caleb = [1,2,3,5]

			expect(caleb).to include(3)
			expect(caleb).to include(1,5)

			expect(caleb).to start_with(1)
			expect(caleb).to end_with(5)

			expect(caleb).to match_array([5,3,2,1])
			expect(caleb).not_to match_array([4,3])

			expect(caleb).to contain_exactly(5,3,2,1)
			expect(caleb).not_to contain_exactly(1,2)
		end

		it "will match string" do 
			string = "i am caleb"

			expect(string).to include('i')
			expect(string).to include('i' , 'caleb')

			expect(string).to start_with('i')
			expect(string).to end_with('caleb')
		end

		it "will match hashes" do

			hash = {:a => 1, :b => 3 , :c => 3}

			expect(hash).to include(:a)
			expect(hash).to include(:a => 1)

			expect(hash).to include(:a => 1 , :c => 3)
			expect(hash).to include({:a => 1 , :c => 3})

			expect(hash).not_to include({'a' => 1 , 'c' => 3})


		end
	end

end