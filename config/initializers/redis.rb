$redis = Redis.new(url: ENV["REDISCLOUD_URL"]) if Rails.env.production?