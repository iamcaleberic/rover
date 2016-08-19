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

            expect(time.to_s).to eq('2016-01-01 02:12:00 +0000'
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

            allow(caleb).to receive(:name).and_return('Kline')
            
            expect(caleb.name).to eq('Kline')
        end

        it "allows stubbing class methods on Ruby Classes" do 
            fixed = Time.new(2016, 1, 1, 2, 12, 0, 0)
            allow(Time).to receive(:now).and_return(fixed)

            expect(Time.now).to eq fixed
            expect(Time.now.to_s).to eq('2016-01-01 02:12:00 +0000'
            )
            expect(Time.now.year).to eq(2016)

        end

        it "allows stubbing database calls a mock object" do
            class Squad
                attr_accessor :name

                def self.find
                end
            end

            dbl = double("Mock squad")
            allow(dbl).to receive(:name).and_return('Goon')
            
            allow(Squad).to receive(:find).and_return(dbl)

            squad = Squad.find
            expect(squad.name).to eq('Goon')

        end

        it "allows stubbing database calls with many mock objects " do
            class Squad
                attr_accessor :name
 
                def self.all
                end
    
            end

            sq1 = double("Squad one", :name => "Goon")
            sq2 = double("Squad two", :name => "Geek")
            
           
            allow(Squad).to receive(:all).and_return([sq1, sq2])

            squads = Squad.all
            expect(squads[1].name).to eq('Geek')
      
        end
    end
    
    context "with message expectations" do
        it "expects a call and allows a response" do
            dbl = double("Scream")
            expect(dbl).to receive(:hey!).and_return("Please Help!")
            dbl.hey!
        end

        it "does not matter in what order" do 
            dbl = double("Multi-step Process")

            expect(dbl).to receive(:step_1)
            expect(dbl).to receive(:step_2)

            dbl.step_2
            dbl.step_1
           
        end

        it "works with #ordered when order matters" do
            dbl = double("Multi-step Process")

            expect(dbl).to receive(:step_1).ordered
            expect(dbl).to receive(:step_2).ordered

            dbl.step_1
            dbl.step_2
        end
    end


    context "with argument constraints " do
        it "expects arguments will match" do
            dbl = double("Call of Duty")
            expect(dbl).to receive(:sort).with('Ghosts')
            dbl.sort('Ghosts')
        end

        it "passes when any arguments are allowed" do
            dbl = double("Call of Duty")
            expect(dbl).to receive(:sort).with(any_args)
            dbl.sort('Ghosts')
        end

        it "works the same with multiple arguments" do
            dbl = double("Call of Duty")
            expect(dbl).to receive(:sort).with('Ghosts', true)
            dbl.sort('Ghosts',true)
        end

        it "allows constraining only some arguments" do
            dbl = double("Call of Duty")
            expect(dbl).to receive(:sort).with('Ghosts', anything ,anything )
            dbl.sort('Ghosts' ,true ,'desc')
        end

        it "allows using other matchers" do
            dbl = double("Call of Duty")
            expect(dbl).to receive(:sort).with(
                a_string_starting_with('G'), 
                an_object_eq_to('desc') | an_object_eq_to('desc'), boolean
            )
            dbl.sort('Ghosts', 'desc' ,true)
        end
    end

    context "with spying abilities" do

        it "can expect a call after it is received" do
            bond = spy("Scream")
            allow(bond ).to receive(:hey!).and_return("Help me!")
            bond.hey!
            expect(bond).to have_received(:hey!)
        end

        it "can use message constraints" do
             bond = spy("Scream")
            allow(bond ).to receive(:hey!).and_return("Help me!")
            bond.hey!
            bond.hey!
            bond.hey!
            expect(bond).to have_received(:hey!).with(no_args).exactly(3).times
        end

        it "can expect any message already sent to a declared spy" do
            bond = spy("Scream")
            # You dont necessarily have to stub a spy before calling it
            # allow(bond ).to receive(:aston)
            bond.aston
            expect(bond).to have_received(:aston)
        end

        it "can expect only allowed messages on partial doubles" do
            class Spy 
                def aston
                    true
                end
            end
            caleb = Spy.new
            # with partial doubles they must be stubbed out first
            allow(caleb).to receive(:aston)
            caleb.aston
            expect(caleb).to have received(:aston)
        end
        
        context "using let and a before hook " do
        end
    end 

end