require "bunny"

Bunny.new.tap do |bunny|
  bunny.start
  exchange = bunny.exchange "bugs"

  queue = bunny.queue "bugs.operator"
  queue.bind exchange, :key => "operator"

  puts "Operator listening ..."
  queue.subscribe do |message|
    puts "Operator received: #{message[:payload].inspect}"
    exchange.publish message[:payload], :key => "workers"
  end
end