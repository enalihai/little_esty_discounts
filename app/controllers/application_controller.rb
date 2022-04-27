class ApplicationController < ActionController::Base

  def holiday_list
    @holidays = HolidayFacade.determine_holidays
  end
end
