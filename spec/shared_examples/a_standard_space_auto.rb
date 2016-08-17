shared_examples_for('a standard space auto') do
    describe 'attributes' do
        it "allows reading and writing for :make" do 
            subject.make = "Test"
			expect(subject.make).to eq("Test")
        end

        it "allows reading and writing of :year " do 
            subject.year = 000
			expect(subject.year).to eq(000)
        end

        it "allows reading and writing of :color" do
            subject.color = "Test"
			expect(subject.color).to eq("Test")
        end
       
        it "Allows reading and writing for :planet" do
			subject.planet = "My planet"
			expect(subject.planet).to eq("My planet")
		end

        it "Allows reading for :wheels" do
			expect(subject.wheels).to eq(4)
		end

		it "Allows writing of doors" 


    end
end