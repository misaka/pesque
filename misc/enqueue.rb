#!/usr/bin/env ruby

require 'rubygems'
require 'resque'

class MOHandler
  @queue = 'mos'

  def self.perform( params )
    puts "received message from #{params[:msisdn]}"
  end
end

Resque.enqueue( MOHandler, { :msisdn => '447760208493', :body => 'Hai.' } )

