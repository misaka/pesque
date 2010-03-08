#!/usr/bin/env ruby

require 'rubygems'
require 'resque'

class MOHandler
  @queue = 'mos'

  def self.perform( params )
    puts "received message from #{params[:msisdn]}"
  end
end

job = Resque.reserve( :mos )
puts "#{job.payload_class}: #{job.args.to_json}"

