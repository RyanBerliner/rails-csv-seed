require 'csv'

task :csv_backup => :environment do
  Dir[Rails.root.join('app/models/*.rb').to_s].each do |filename|
    klass = File.basename(filename, '.rb').camelize.constantize
    if klass != ApplicationRecord
      backup_table(klass);
    end
  end
  puts "\nCSV backup complete"
end

def backup_table(table)
  table_name = table.name.demodulize
  count = 0
  print table_name
  (25 - table_name.length).times do
    print '.'
  end
  CSV.open(Rails.root.join('db', 'csv_backups', table_name + '.csv'), 'w') do |csv|
    # Print out the headers
    headers = []
    table.columns.each do |header|
      headers.push(header.name)
    end
    csv << headers
    # Add all the records
    records = table.all
    records.each do |record|
      row = []
      record.attributes.each_pair do |name, value|
        row.push(value)
      end
      count += 1
      csv << row
    end
  end
  puts count.to_s
end
