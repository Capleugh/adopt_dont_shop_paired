class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def all_favorites
    # @contents.map do |pet_id, pet|
    #   pet
    # end
    @contents.values
  end

  def total_count
    # require "pry"; binding.pry
    @contents.values.count
  end

  # def count_of(id)
  #   @contents[id.to_s].to_i
  # end
end
