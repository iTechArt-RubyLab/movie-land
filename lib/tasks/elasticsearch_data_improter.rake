namespace :elasticsearch do
  desc 'Import data for elasticsearch'
  task :import => :environment do
    Importers::ElasticsearchData.import
    puts 'Data for elasticsearch has been imported'
  end
end
