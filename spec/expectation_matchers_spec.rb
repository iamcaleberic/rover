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

	describe "some more useful matchers " do
		it "will match strings with a regex" do 
			string = "The order has been received."
			expect(string).to match(/order(.+)received/)

			expect('123').to match(/\d{3}/)
			expect(123).not_to match(/\d{3}/) # only works with strings
 			
 			email = "iamcaleb@tuta.com"
 			expect(email).to match(/\A\w+@\w+\.\w{3}\Z/)

 		end

		it "will match object types" do 
			expect('test').to be_instance_of(String)
			expect('test').to be_instance_of(String)

			expect('test').to be_kind_of(String)
			expect('test').to be_a_kind_of(String)

			expect('test').to be_a(String)

			expect([1,2,3]).to be_an(Array)

		end

		it "will match objects with #respond_to" do 
			string = 'shadowscript'
			expect(string).to respond_to(:length)
			expect(string).not_to respond_to(:sort)

		end

		it "will match class instances with #have_attributes" do
			class Rover
				attr_accessor :make , :planet , :year , :color
			end

			killjoy = Rover.new 
			killjoy.make = 'Moon offroad'
			killjoy.year = '2073'
			killjoy.planet = 'Ceres'
			killjoy.color = 'Black'

			expect(killjoy).to have_attributes(:color => 'Black')
			expect(killjoy).to have_attributes(
				:make => 'Moon offroad' , :year => '2073' ,:color=> 'Black'
				)
		end


		it "will match anything with #satisfy" do 

			expect(10).to satisfy do |value|
				(value >=5) && (value <=10) && (value % 2 == 0)

			end

		end
	end

	describe 'predicate matchers' do 
		it "will match be_* to custom methods ending in ?" do
			# ruby methods that rspec drops be_ and adds the ? 

			expect([]).to be_empty 
			expect(1).to be_integer
			expect(0).to be_zero
			expect(1).to be_nonzero
			expect(1).to be_odd
			expect(2).to be_even

			class Jet 
				def visible? ;true ;end
			end

			royal = Jet.new
			expect(royal).to be_visible # a custom method being called by rspec be_

			# same as 

			expect(royal.visible?).to be true
		end

		it "will match have_* to custom methods like has_*" do
			# changes have_ to has_ and adds ? ie calls on method on object

			# built in methods
			hash = {:a => 1 , :b => 2}
			expect(hash).to have_key(:a)
			expect(hash).to have_value(2)


			# custom methods

			class Buyer
				def has_pending_order? ;true ; end
			end			

			buyer = Buyer.new 

			expect(buyer).to have_pending_order

			#same as
			expect(buyer.has_pending_order?).to be true




		end
	end 

	describe "Observation matchers" do
		# for obs matchers use expect {} instead of ()
		it "will match when events  change  object attributes" do
			array = []
			expect {array << 1 }.to change(array , :empty?).from(true).to(false)

			class WebHits
				attr_accessor :count
				def initialize; @count = 0; end
				def increment; @count += 1; end
			end

			hits = WebHits.new
			expect { hits.increment }.to change(hits, :count).from(0).to(1)
		end

		it "will match when events change any values" do 
			# calls test before block and the afterwards
			x = 10
			expect{ x += 1}.to change {x}.from(10).to(11)
			expect{ x += 1}.to change {x}.by(1)
			expect{ x += 1}.to change {x}.by_at_least(1)
			expect{ x += 1}.to change {x}.by_at_most(1)		

			z = 11
			expect {z += 1}.to change {z % 3 }.from(2).to(0)
		end

		it "will match when errors are railsed" do 
			expect { raise StandardError }.to raise_error 
			expect { raise StandardError }.to raise_exception

			expect { 1 / 0 }.to raise_error(ZeroDivisionError)
			expect { 1 / 0 }.to raise_error.with_message("divided by 0")
			expect { 1 / 0 }.to raise_error.with_message(/divided/)

			expect { 1 / 1 }.not_to raise_error
		end

		it "will match when output is generated" do 
			expect { print('hello') }.to output.to_stdout
			expect { print('hello') }.to output('hello').to_stdout
			expect { print('hello') }.to output(/ll/).to_stdout
		
			expect { warn('problem') }.to output(/problem/).to_stderr
		end
	end

	describe "Compound expectations" do
		it "will match using: and, or, & ,|" do
			expect([1,2,3,4]).to start_with(1).and end_with(4)

			expect([1,2,3,4]).to start_with(1) & include(2)
			
			expect(10 * 10 ).to be_odd.or be > 50

			array = ['hello ','goodbye'].shuffle 
			expect(array.first).to eq("hello") | eq("goodbye")

		end
	end

	describe "composing matchers" do
		it "will match all collection elements using a matchers" do
			array = [1,2,3]
			expect(array).to all(be < 5)
		end

		it "will match by sending matchers as arguments to matchers" do
			string = 'hello'
			expect { string = 'goodbye'}.to change { string }.from( match(/ll/)).to(match(/oo/))
			hash = {:a => 1 , :b => 2 , :c => 3}
			expect(hash).to include(:a => be_odd , :b => be_even , :c => be_odd)

			expect(hash).to include(:a => be > 0 , :b => be_within(2).of(4))


		end

		it "will match using noun-phrase aliases for matchers" do
			# built-in aliases

			fruits = ['apple' , 'banana' ,'cherry']
			expect(fruits).to start_with(start_with('a')) & include(match(/a.a.a/)) &
			end_with( end_with('y') )

			# rewrite using aliases
			fruits = ['apple' , 'banana', 'cherry']
			expect(fruits).to start_with(a_string_starting_with('a')) & include(a_string_matching(/a.a.a/)) &
			 end_with(a_string_ending_with('y'))
		
			array = [1,2,3,4]
			expect(array).to start_with(be <= 2) | end_with(be_within(1).of(5))

			# rewrite using aliases

			array = [1,2,3,4]
			expect(array).to start_with( a_value <= 2) | end_with(a_value_within(1).of(5)) 

		end
	end
end