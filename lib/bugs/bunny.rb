Thread.new do
  Bunny.new.tap do |bunny|
    bunny.start
    exchange = bunny.exchange "bugs"

    queue = bunny.queue "bugs.workers.#{Process.pid}"
    queue.bind exchange, :key => "workers"

    puts "[#{Process.pid}] Worker listening ..."
    queue.subscribe do |message|
      puts "[#{Process.pid}] Worker received: #{message[:payload].inspect}"
      Bugs.messages << message[:payload]
    end
  end
end