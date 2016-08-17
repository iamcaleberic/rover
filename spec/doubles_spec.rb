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

end