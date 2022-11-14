class Ride
  attr_accessor :rider_log
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :total_revenue

  def initialize(attributes)
    @name = attributes[:name]
    @min_height = attributes[:min_height]
    @admission_fee = attributes[:admission_fee]
    @excitement = attributes[:excitement]
    @total_revenue = 0
    @rider_log = Hash.new(0)
  end

  def board_rider(visitor)
    return if !visitor.preferences.include?(@excitement)
    return if !visitor.tall_enough?(min_height)

    @rider_log[visitor] += 1
    visitor.spending_money -= @admission_fee
    @total_revenue += @admission_fee
  end
end