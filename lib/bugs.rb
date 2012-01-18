require "bugs/bunny"

module Bugs
  def self.messages
    Thread.main[:messsages] ||= []
  end
  def self.publish(message)
    Bunny.new.tap do |bunny|
      bunny.start
      bunny.exchange("bugs").publish "[#{Process.pid}] #{message}", :key => "operator"
      bunny.stop
    end
  end
end