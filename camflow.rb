#!/usr/bin/env ruby

require 'rgl/adjacency'
require 'rgl/dot'
require 'rgl/topsort'
require 'rgl/transitivity'
require 'json'

class CamFlow
  attr_reader :dg

  def initialize filename = nil
    @dg = RGL::DirectedAdjacencyGraph.new
    self.read_json_file filename
  end

  def read_json_file filename
    if filename != nil
      self.parse_json File.read(filename) unless !File.file?(filename)
      print "File does not exist\n" unless File.file?(filename)
    end
  end

  def read_log_file filename
    i = 1
    if filename != nil
      open(filename) do |file|
        file.each_line do |line|
          line = line.sub /\[[0-9 :-]*\]\t[A-Z]*[ ]*:[ ]*/, ''
          self.parse_json line
        end
      end unless !File.file?(filename)
      print "File does not exist\n" unless File.file?(filename)
    end
  end

  def parse_json string
    begin
      json = JSON.parse(string)
    rescue JSON::ParserError
      print "Parsing failed...\n"
      print string
      print "\n"
      return
    end

    json['used'].each do |k, v|
      @dg.add_edge v['prov:activity'], v['prov:entity']
    end unless !json.key? 'used'


    json['wasGeneratedBy'].each do |k, v|
      @dg.add_edge v['prov:entity'], v['prov:activity']
    end unless !json.key? 'wasGeneratedBy'

    json['wasDerivedFrom'].each do |k, v|
      @dg.add_edge v['prov:generatedEntity'], v['prov:usedEntity']
    end unless !json.key? 'wasDerivedFrom'

    json['wasInformedBy'].each do |k, v|
      @dg.add_edge v['prov:informed'], v['prov:informant']
    end unless !json.key? 'wasInformedBy'

    json['wasAssociatedWith'].each do |k, v|
      @dg.add_edge v['prov:activity'], v['prov:agent']
      @dg.add_edge v['prov:agent'], v['prov:plan'] unless !v.key? 'prov:plan'
    end unless !json.key? 'wasAssociatedWith'
  end

  def information
    str = "Graph:\n"
    if @dg.directed?
      str += "directed\n"
    else
      str += "not directed\n"
    end

    if @dg.acyclic?
      str += "acyclic\n"
    else
      str += "not acyclic\n"
    end

    str += @dg.num_edges.to_s() +" edges.\n"
    str += @dg.num_vertices.to_s() +" vertices.\n"
  end

  def apply_transitive_reduction
    @dg = @dg.transitive_reduction
  end
end

def help
  print "-[l/j] filename -[i/s/p/d]\n"
  print "l: log file\n"
  print "j: json file\n"
  print "i: information\n"
  print "s: svg file\n"
  print "p: png file\n"
  print "d: generate .dot file and call dotty\n"
end

cf = CamFlow.new

case ARGV[0]
when '-h'
  help
  exit
when '-l'
  print "Reading log file...\n"
  file_name = ARGV[1]
  cf.read_log_file file_name
when '-j'
  print "Reading JSON file...\n"
  file_name = ARGV[1]
  cf.read_json_file file_name
else
  print "here\n"
  help
  exit
end

case ARGV[2]
when '-i'
  print cf.information
when '-s'
  cf.dg.write_to_graphic_file('svg')
when '-p'
  cf.dg.write_to_graphic_file('png')
when '-d'
  cf.dg.dotty
else
  help
end
