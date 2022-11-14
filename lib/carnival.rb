class Carnival
  attr_reader :duration,
              :rides

  def initialize(duration)
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    @rides.max_by do |ride|
      ride.rider_log.values.sum
    end
  end

  def most_profitable_ride
    @rides.max_by do |ride|
      ride.total_revenue
    end
  end

  def total_revenue
    @rides.sum do |ride|
      ride.total_revenue
    end
  end

  def visitor_count
    visitors = @rides.map do |ride|
      ride.rider_log.keys
    end.flatten.uniq.count
  end

  # def summary
  #   {
  #     visitor_count: 
  #   }
  # end
end