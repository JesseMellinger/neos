class TableFormatter
  def self.get_column_labels
    { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
  end

  def self.get_column_data(asteroid_list)
    get_column_labels().each_with_object({}) do |(col, label), hash|
      hash[col] = {
        label: label,
        width: [asteroid_list.map { |asteroid| asteroid[col].size }.max, label.size].max}
    end
  end

  def self.format_row_data(row_data, column_info)
    row = row_data.keys.map { |key| row_data[key].ljust(column_info[key][:width]) }.join(' | ')
    puts "| #{row} |"
  end

  def self.create_rows(asteroid_data)
    asteroid_data.each { |asteroid| format_row_data(asteroid, get_column_data(asteroid_data)) }
  end
end
