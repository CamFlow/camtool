module CamTool
  class EdgeValidator < ProvJSONParser
    def initialize
    end

    def used k, v
      puts v['prov:entity']
      bytes = Base64.decode64(v['prov:entity']).bytes.to_a
      puts "%08b" % bytes[7]
    end

    def wasGeneratedBy k, v

    end

    def wasDerivedFrom k, v

    end

    def wasInformedBy k, v

    end

    def wasAssociatedWith k, v

    end
  end
end
