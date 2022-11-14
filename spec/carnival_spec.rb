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

  before(:each) do
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:thrilling)
  end

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

  describe '#most_popular_ride' do
    it 'returns the most popular ride' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expect(carnival.most_popular_ride).to eq(ride1)
    end
  end

  describe '#most_profitable_ride' do
    it 'returns the most profitable ride' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expect(carnival.most_profitable_ride).to eq(ride2)
    end
  end

  describe '#total_revenue' do
    it 'returns the total revenue for the carnival' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expect(carnival.total_revenue).to eq(10)
    end
  end

  describe '#visitors' do
    it 'returns an array of unique visitors' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expect(carnival.visitors).to eq([visitor1,visitor2,visitor3])
    end
  end

  describe '#visitor_info' do
    it 'stores the fave ride and money spent for a visitor' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expected = {
                  visitor: visitor1,
                  fave_ride: carnival.fave_ride(visitor1),
                  money_spent: carnival.money_spent(visitor1)
                 }
      
      expect(carnival.visitor_info(visitor1)).to eq(expected)
    end
  end

  describe '#all_visitor_info' do
    it 'returns all visitor info' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expected = [
                  carnival.visitor_info(visitor1),
                  carnival.visitor_info(visitor2),
                  carnival.visitor_info(visitor3)
      ]
      expect(carnival.all_visitor_info).to eq(expected)
    end
  end

  describe '#fave_ride' do
    it 'returns the favorite ride of a visitor' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expect(carnival.fave_ride(visitor1)).to eq(ride1)
    end
  end

  describe '#money_spent' do
    it 'returns the amount of money a visitor spent' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expect(carnival.money_spent(visitor1)).to eq(7)
      expect(carnival.money_spent(visitor2)).to eq(1)
      expect(carnival.money_spent(visitor3)).to eq(2)
    end
  end

  describe '#riders' do
    it 'returns a list of riders for a specific ride' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expect(carnival.riders(ride1)).to eq([visitor1,visitor2])
      expect(carnival.riders(ride2)).to eq([visitor1])
      expect(carnival.riders(ride3)).to eq([visitor3])
    end
  end

  describe '#ride_info' do
    it 'returns riders and ride total revenue' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expected = {
                  ride: ride1,
                  riders: [visitor1,visitor2],
                  total_revenue: ride1.total_revenue
      }
      expect(carnival.ride_info(ride1)).to eq(expected)
    end
  end

  describe '#all_ride_info' do
    it 'returns all ride info' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expected = [
        carnival.ride_info(ride1),
        carnival.ride_info(ride2),
        carnival.ride_info(ride3)
      ]

      expect(carnival.all_ride_info).to eq(expected)
    end
  end

  describe '#summary' do
    it 'is a summary for the whole carnival' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor1)
      ride3.board_rider(visitor2)
      ride3.board_rider(visitor3)
        
      expect(carnival.summary[:visitor_count]).to eq(3)
      expect(carnival.summary[:revenue_earned]).to eq(10)
      expect(carnival.summary[:all_visitor_info].size).to eq(3)
      expect(carnival.summary[:all_visitor_info][0]).to eq(carnival.visitor_info(visitor1))
      expect(carnival.summary[:all_ride_info].size).to eq(3)
      expect(carnival.summary[:all_ride_info][0]).to eq(carnival.ride_info(ride1))
    end
  end
end