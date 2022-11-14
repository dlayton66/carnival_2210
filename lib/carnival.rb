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

  def visitors
    @rides.map do |ride|
      ride.rider_log.keys
    end.flatten.uniq
  end

  def visitor_hash(visitor)
    {
      name: visitor.name,
      fave_ride: fave_ride(visitor),
      money_spent: money_spent(visitor)
    }
    visitors.each do |visitor|
      visitor_hash[visitor]
    end
  end

  def fave_ride(visitor)
    @rides.max_by do |ride|
      ride.rider_log[visitor]
    end
  end

  def money_spent(visitor)
    @rides.sum do |ride|
      ride.rider_log[visitor]*ride.admission_fee
    end
  end

  # def summary
  #   {
  #     visitor_count: visitors.count,
  #     revenue_earned: total_revenue,
  #     visitor_info: [
  #                   
  #                   ]
  #   }
  # end
end