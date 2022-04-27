class HolidayService
  def self.holidays
    url = "https://date.nager.at/swagger/index.html"
    Faraday.new(url)
  end

  def self.get_holidays
    response = holidays.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
    JSON.parse(response.body, symbolize_names: true)
  end
end
