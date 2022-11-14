require './lib/visitor'
require './lib/ride'

RSpec.describe Ride do
  let(:ride1) { Ride.new({ 
                          name: 'Carousel', 
                          min_height: 24, 
                          admission_fee: 1, 
                          excitement: :gentle
                          })
              }
  let(:visitor1) { Visitor.new('Bruce', 54, '$10') }
  let(:visitor2) { Visitor.new('Tucker', 36, '$5') }
              
  it 'exists and has attributes' do
    expect(ride1).to be_a Ride
    expect(ride1.name).to eq("Carousel")
    expect(ride1.min_height).to eq(24)
    expect(ride1.admission_fee).to eq(1)
    expect(ride1.excitement).to eq(:gentle)
    expect(ride1.total_revenue).to eq(0)
  end

  describe '#board_rider' do
    it 'adds 1 to visitor rides in rider_log' do
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)

      expected = {
                  visitor1 => 2,
                  visitor2 => 1
      }
      expect(ride1.rider_log).to eq(expected)
    end
  end
end