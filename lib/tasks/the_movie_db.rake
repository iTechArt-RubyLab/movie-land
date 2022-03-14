desc 'Fill data base with TheMovieDB Api'
task :themoviedb => :environment do
  TheMovieDb.new.call
end

