class ConsumersController < ApplicationController
  def index
    @consumers = token.get("/api/v4/consumers", params: {filter: "active"}).parsed["consumers"]
  end

  def show
    @start_date = params[:start_date] || 2.months.ago.to_date
    @end_date = params[:end_date] || 1.month.ago.to_date

    path = "/api/v4/consumers/#{params[:id]}/time_of_use_readings"
    result = token.get(path, params: {start_date: @start_date, end_date: @end_date})
    @readings = result.parsed["time_of_use_readings"]
  end
end
