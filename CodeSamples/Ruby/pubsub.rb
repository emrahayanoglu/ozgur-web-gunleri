#!/usr/bin/env ruby
# encoding: utf-8
 
require "rubygems"
require "amqp"
 
EventMachine.run do
  connection = AMQP.connect(:host => '127.0.0.1', :port => 5001)
  puts "Connected to AMQP broker. Running #{AMQP::VERSION} version of the gem..."
 
  channel  = AMQP::Channel.new(connection)
  queue    = channel.queue("owg2013.helloworld1", :auto_delete => true)
  exchange = channel.direct("")
 
  queue.subscribe do |payload|
    puts "Received a message: #{payload}. Disconnecting..."
    connection.close { EventMachine.stop }
  end
 
  exchange.publish "Hello, world!", :routing_key => queue.name
end