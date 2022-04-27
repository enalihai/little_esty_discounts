class HolidayFacade
  def self.determine_holidays
    json = HolidayService.get_holidays
    output = json.map do |input|
      Holiday.new(input)
    end
    output.first(3)
  end
end
