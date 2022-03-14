class TheMovieDbWorker
  include Sidekiq::Worker
  queue_as :default

  def perform
    TheMovieDb.new.call
  end
end
