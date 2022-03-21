desc 'Fill data base with TheMovieDB Api'
task :themoviedb => :environment do
  Integration::TheMovieDb.new.call
end

