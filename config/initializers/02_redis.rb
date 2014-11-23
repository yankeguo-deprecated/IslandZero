$redis = Redis.new({ url: "#{ENV['REDIS_URL']}/0", driver: :hiredis })
