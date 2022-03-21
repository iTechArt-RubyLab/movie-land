class TheMovieDbWorker
  include Sidekiq::Worker
  queue_as :default

  def perform
    Integration::TheMovieDb.new.call
  end
end
