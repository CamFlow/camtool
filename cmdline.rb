#!/usr/bin/env ruby

require_relative 'lib/camflow'
require 'rgl/dot'
require 'rgl/topsort'
require 'rgl/transitivity'

CamFlow::ProvJSONtoRGL.new.read_log_file('./json/merge.json').jpg
