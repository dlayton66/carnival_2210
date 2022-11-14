require './lib/visitor'
require './lib/ride'
require './lib/carnival'

RSpec.describe Carnival do
  let(:carnival) { Carnival.new(7) }
  let(:ride1) { Ride.new({ 
                          name: 'Carousel', 
                          min_height: 24, 
                          admission_fee: 1, 
                          excitement: :gentle
                        })
              }
  let(:ride2) { Ride.new({ 
                          name: 'Ferris Wheel', 
                          min_height: 36, 
                          admission_fee: 5, 
                          excitement: :gentle
                        })
              }   
  let(:ride3) { Ride.new({ 
                          name: 'Roller Coaster', 
                          min_height: 54, 
                          admission_fee: 2, 
                          excitement: :thrilling
                        })
              }   
  let(:visitor1) { Visitor.new('Bruce', 54, '$10') }
  let(:visitor2) { Visitor.new('Tucker', 36, '$5') }
  let(:visitor3) { Visitor.new('Penny', 64, '$15') }

  it 'exists and has attributes' do
    expect(carnival).to be_a Carnival
    expect(carnival.duration).to eq(7)
    expect(carnival.rides).to eq([])
  end

  describe '#add_ride' do
    it 'adds a ride to the carnival' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      expect(carnival.rides).to eq([ride1,ride2,ride3])
    end
  end
end