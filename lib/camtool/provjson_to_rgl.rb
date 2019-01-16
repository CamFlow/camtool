require 'rgl/adjacency'
require 'rgl/dot'
require 'rgl/topsort'
require 'rgl/transitivity'

module CamTool
  class ProvJSONtoRGL < ProvJSONParser
    attr_reader :dg
    attr_reader :map
    attr_reader :edges

    def initialize
      @dg = RGL::DirectedAdjacencyGraph.new # initialise the graph structure
      @map = Hash.new
      @edges = Hash.new
    end

    def entity k, v
      @map[k] = v
    end

    def activity k, v
      @map[k] = v
    end

    def agent k, v
      @map[k] = v
    end

    def used k, v
      @dg.add_edge v['prov:activity'], v['prov:entity']
      @edges[v['prov:activity']+v['prov:entity']] = v
    end

    def wasGeneratedBy k, v
      @dg.add_edge v['prov:entity'], v['prov:activity']
      @edges[v['prov:entity']+v['prov:activity']] = v
    end

    def wasDerivedFrom k, v
      @dg.add_edge v['prov:generatedEntity'], v['prov:usedEntity']
      @edges[v['prov:generatedEntity']+v['prov:usedEntity']] = v
    end

    def wasInformedBy k, v
      @dg.add_edge v['prov:informed'], v['prov:informant']
      @edges[v['prov:informed']+v['prov:informant']] = v
    end

    def wasAssociatedWith k, v
      @dg.add_edge v['prov:activity'], v['prov:agent']
      @edges[v['prov:activity']+v['prov:agent']] = v
      @dg.add_edge v['prov:agent'], v['prov:plan'] unless !v.key? 'prov:plan'
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
      str += (@dg.num_edges.to_f/@dg.num_vertices).to_s() + " edges/vertices ratio.\n"
    end

    def validate
      abort 'Graph is not directed!' unless @dg.directed?
      abort 'Graph is not acyclic!' unless @dg.acyclic?
    end

    def svg
      @dg.write_to_graphic_file('svg')
    end

    def jpg
      @dg.write_to_graphic_file('jpg')
    end

    def png
      @dg.write_to_graphic_file('png')
    end

    def list
      a = @dg.topsort_iterator.to_a
      a.each do |v|
        puts v + ' ' + @map[v]['prov:label']
      end
    end
  end
end
