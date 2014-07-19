require 'csv'
require 'date'

text = File.open("Violations-2012.csv").read

csv = CSV.new(text, :headers => true, :header_converters => :symbol)
csv.to_a.map { |row| row.to_h }.group_by { |hash| hash[:violation_category] }.each do |k, v|
  biggest = v.inject(Date.new(2000, 1, 1)) do |memo, hash|
    date = Date.strptime((hash[:violation_date][0..9]), '%Y-%m-%d')
    memo > date ? memo : date
  end
  smallest = v.inject(Date.new(2000, 1, 1)) do |memo, hash|
    date = Date.strptime((hash[:violation_date][0..9]), '%Y-%m-%d')
    memo < date ? memo : date
  end

  p "Violation category: #{k}"
  p "Number of violations: #{v.count}"
  p "Earliest violation date: #{smallest}"
  p "Latest violation date: #{biggest}"
  p '*'*8
end
