#!/usr/bin/env ruby

require_relative 'lib/camflow'
require 'rgl/dot'
require 'rgl/topsort'
require 'rgl/transitivity'

print CamFlow::ProvJSONtoRGL.new.read_log_file('../audit.log').png
#CamFlow::MQTTBreaker.new.break_log_file('../audit.log')
