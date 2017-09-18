require 'csv'

total_count = 0
total_error = 0

Dir[Rails.root.join('app/models/*.rb').to_s].each do |filename|
  klass = File.basename(filename, '.rb').camelize.constantize
  if klass != ApplicationRecord
    class_name = klass.name.demodulize
    class_count = 0
    class_error = 0
    puts class_name
    text = File.read(Rails.root.join('db', 'csv_backups', class_name + '.csv'))
    rows = CSV.parse(text, :headers => true)
    rows.each do |row|
      record = klass.new
      row.each do |key, value|
        record[key] = value
      end
      if record.save(:validate => false)
        puts " * INSERTED " + class_name + " Id: " + record['id'].to_s
        class_count += 1
        total_count += 1
      else
        puts " * ERROR " + class_name + " Id: " + record['id'].to_s
        class_error += 1
        total_error += 1
      end
    end
    puts " * " + class_count.to_s + " imported, " + class_error.to_s + " errors"
  end
end
puts "Seeds Overview"
puts total_count.to_s + " imported, " + total_error.to_s + " errors"
puts "\nDatabase seed complete"
