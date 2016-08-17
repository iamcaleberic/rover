describe "Doubles" do 
    it "allows stubbing methods" do 
        dbl = double("Scream")  
        allow(dbl).to receive(:hey!)
        expect(dbl).to respond_to(:hey!)
    end

    it "allows stubbing a response with a block " do
        dbl = double("Scream")
        allow(dbl).to receive(:hey!) { "Please Help me!"}

        expect(dbl.hey!).to eq("Please Help me!")
    end

    it "allows stubbing response with #and_return" do
        dbl = double("Scream")
        allow(dbl).to receive(:hey!).and_return("Please Help me!")

        expect(dbl.hey!).to eq("Please Help me!")
    end

    it "allows stubbing multiple methods with hash syntax" do
        dbl = double("Kresh")
        allow(dbl).to receive_messages(:name => "Kresh" , :initials => "KS")

        expect(dbl.name).to eq("Kresh")
        expect(dbl.initials).to eq("KS")
    end

    it "allows stubbing with a hash argument to #double" do
        dbl = double("Kresh" ,  :name => "Kresh" , :initials => "KS")
        expect(dbl.name).to eq("Kresh")
        expect(dbl.initials).to eq("KS")
    end

    it "allows stubbing multiple responses with #and_return" do
        die = double("Die")
        allow(die).to receive(:roll).and_return(1,5,2,6)
        expect(die.roll).to eq(1)
        expect(die.roll).to eq(5)
        expect(die.roll).to eq(2)
        expect(die.roll).to eq(6)
        expect(die.roll).to eq(6)
    end

    context 'with partial test doubles' do
        it "allows stubbing instance methods on Ruby Classes" do 
            time = Time.new(2016, 1, 1, 2, 12, 0, 0)
            allow(time).to receive(:year).and_return(1905)

            expect(time.to_s).to eq('2016-01,01 12:00:00 +0100'
            )
            expect(time.year).to eq(1905)
        end

        it "allows stubbing instance methods on custom classes" do
            class Killjoy
                attr_accessor :name
            end
            caleb =  Killjoy.new
            caleb.name = "Mitigator" 
            expect(caleb.name).to eq("Mitigator")

            allow(hero).to receive(:name).and_return('Kline')
            
            expect(hero.name).to eq('Kline')
        end

        it "allows stubbing class methods on Ruby Classes" do 
            fixed = Time.new(2016, 1, 1, 2, 12, 0, 0)
            allow(Time).to receive(:now).and_return(fixed)

            expect(Time.now).to eq fixed
            expect(Time.now.to_s).to eq('2016-01,01 12:00:00 +0100'
            )
            expect(Time.now.year).to eq(2016)

        end

        it "allows stubbing database calls a mock object" do
        end
    end

end