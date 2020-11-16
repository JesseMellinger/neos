require 'faraday'
require 'figaro'
require 'pry'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects
  attr_reader :date, :asteroid_data

  def initialize(date)
    @date = date
    @asteroid_data = parse_asteroid_data(Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: date, api_key: ENV['nasa_api_key']}
    ).get('/neo/rest/v1/feed'))
  end

  def get_neos_by_date
    {
      asteroid_list: format_asteroid_data(),
      biggest_asteroid: find_largest_asteroid(),
      total_number_of_asteroids: total_number_of_asteroids()
    }
  end

  def parse_asteroid_data(data)
    JSON.parse(data.body, symbolize_names: true)[:near_earth_objects][:"#{@date}"]
  end

  def find_largest_asteroid()
    @asteroid_data.map do |asteroid|
      asteroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end.max { |a,b| a <=> b}
  end

  def total_number_of_asteroids
    @asteroid_data.count
  end

  def format_asteroid_data
    @asteroid_data.map do |asteroid|
      {
        name: asteroid[:name],
        diameter: "#{asteroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{asteroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
  end
end
