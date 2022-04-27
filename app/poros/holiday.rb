class Holiday
  attr_reader :name, :date

  def initialize(input)
    @name = input[:name]
    @date = input[:date]
  end 
end
