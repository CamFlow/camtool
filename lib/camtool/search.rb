module CamTool
  class Search < ProvJSONParser
    attr_reader :map

    def initialize
      @map = Hash.new(0)
    end

    def used k, v
      @map[k] = v
    end

    def wasGeneratedBy k, v
      @map[k] = v
    end

    def wasDerivedFrom k, v
      @map[k] = v
    end

    def wasInformedBy k, v
      @map[k] = v
    end

    def wasAssociatedWith k, v
      @map[k] = v
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

    def search id
      puts @map[id]
    end
  end
end
