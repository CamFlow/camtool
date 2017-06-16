#!/usr/bin/env ruby

require_relative 'lib/camflow'
require 'rgl/dot'
require 'rgl/topsort'
require 'rgl/transitivity'

print CamFlow::ProvJSONtoRGL.new.read_log_file('log/audit.log').information
#CamFlow::MQTTBreaker.new.break_log_file('../audit.log')
CamFlow::EdgeCounter.new.read_log_file('log/audit.log').show
CamFlow::VertexCounter.new.read_log_file('log/audit.log').show
