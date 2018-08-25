namespace :drain do
  task hits: :environment do
    DrainHitsQueueService.new.run
  end

  task misses: :environment do
    DrainMissQueueService.new.run
  end
end
