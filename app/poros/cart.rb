class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def all_favorites
    @contents.values
  end

  def total_count
    @contents.values.count
  end

  def remove_favorite(id)
    @contents.delete(id.to_s)
  end

  def empty?
    # require "pry"; binding.pry
    @contents.count == 0
  end

  def remove_all
    # require "pry"; binding.pry
    @contents = Hash.new({})
  end
end
