module CamTool
  class NodePresenceValidator < ValidatorUtils
    attr_reader :edges
    attr_reader :nodes
    attr_reader :sources
    attr_reader :destinations

    def initialize
      @edges = Hash.new
      @nodes = Hash.new
      @sources = Hash.new
      @destinations = Hash.new
    end

    def used k, v
      @edges[k] = v
      @destinations[k] = v['prov:entity']
      @sources[k] = v['prov:activity']
    end

    def wasGeneratedBy k, v
      @edges[k] = v
      @destinations[k] = v['prov:activity']
      @sources[k] = v['prov:entity']
    end

    def wasDerivedFrom k, v
      @edges[k] = v
      @destinations[k] = v['prov:generatedEntity']
      @sources[k] = v['prov:usedEntity']
    end

    def wasInformedBy k, v
      @edges[k] = v
      @destinations[k] = v['prov:informant']
      @sources[k] = v['prov:informed']
    end

    def wasAssociatedWith k, v
      @edges[k] = v
      @destinations[k] = v['prov:agent']
      @sources[k] = v['prov:activity']
    end

    def entity k, v
      abort "entity is of wrong type:  #{v}." unless is_entity? k
      @nodes[k]=v
    end

    def activity k, v
      abort "activity is of wrong type:  #{v}." unless is_activity? k
      @nodes[k]=v
    end

    def agent k, v
      abort "agent is of wrong type:  #{v}." unless is_agent?(k) || v['prov:type']=='machine'
      @nodes[k]=v
    end

    def validate
      a = []
      @sources = @sources.sort_by { |k, v| @edges[k]['cf:id'].to_i }.to_h
      @sources.each do |k, v|
        puts "Could not find source #{v}\nin\n#{@edges[k]}" unless @nodes.has_key? v
        puts "destination:\n#{@destinations[k]}:#{@nodes[@destinations[k]]}\n\n" unless @nodes.has_key? v
        a << v unless @nodes.has_key? v
      end

      @destinations = @destinations.sort_by { |k, v| @edges[k]['cf:id'].to_i }.to_h
      @destinations.each do |k, v|
        puts "Could not find destination #{v}\nin\n#{@edges[k]}" unless @nodes.has_key? v
        puts "source:\n#{@sources[k]}:#{@nodes[@sources[k]]}\n\n" unless @nodes.has_key? v
        a << v unless @nodes.has_key? v
      end
      if !a.empty?
        puts "#{a.length} edge(s) with missing element."
        a = a.uniq
        puts "#{a.length} missing element(s).\n\n"
        a.each do |v|
          puts "Entity: "  unless !is_entity? v
          puts "Activity: "  unless !is_activity? v
          puts "Agent: "  unless !is_agent? v
          puts v
          puts "\n"
        end
        abort 'Verification failed. Missing verticies.'
      end
    end
  end
end
