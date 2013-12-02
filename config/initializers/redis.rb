$redis = Redis.new

Nest.class_eval do
  def initialize(key, redis=$redis)
    super(key.to_param)
    @redis = redis
  end

  def [](key)
    self.class.new("#{self}:#{key.to_param}", redis)
  end
end
