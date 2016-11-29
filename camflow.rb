require 'rgl/adjacency'
require 'rgl/dot'
require 'rgl/topsort'
require 'rgl/transitivity'
require 'json'

class CamFlow
  attr_reader :dg

  def initialize filename = nil
    @dg = RGL::DirectedAdjacencyGraph.new
    if filename != nil
      self.parse_json File.read(filename) unless !File.file?(filename)
      print "File does not exist\n" unless File.file?(filename)
    end
  end

  def parse_json string
    json = JSON.parse(string)

    json['used'].each do |k, v|
      dg.add_edge v['prov:activity'], v['prov:entity']
    end unless !json.key? 'used'


    json['wasGeneratedBy'].each do |k, v|
      dg.add_edge v['prov:entity'], v['prov:activity']
    end unless !json.key? 'wasGeneratedBy'

    json['wasDerivedFrom'].each do |k, v|
      dg.add_edge v['prov:generatedEntity'], v['prov:usedEntity']
    end unless !json.key? 'wasDerivedFrom'

    json['wasInformedBy'].each do |k, v|
      dg.add_edge v['prov:informed'], v['prov:informant']
    end unless !json.key? 'wasInformedBy'

    json['wasAssociatedWith'].each do |k, v|
      dg.add_edge v['prov:activity'], v['prov:agent']
      dg.add_edge v['prov:agent'], v['prov:plan'] unless !v.key? 'prov:plan'
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

file_name = ARGV[0]

cf = CamFlow.new(ARGV[0])
print cf.information
cf.apply_transitive_reduction
print cf.information
cf.dg.write_to_graphic_file('jpg')
