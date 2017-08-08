module CamTool
  class EdgeValidator < ProvJSONParser
    def initialize
    end

    def is_relation? id
      bytes = Base64.decode64(id).bytes.to_a
      type = bytes[7] & 0xF0
      return type == 0x80
    end

    def is_activity? id
      bytes = Base64.decode64(id).bytes.to_a
      type = bytes[7] & 0xF0
      return type == 0x40
    end

    def is_entity? id
      bytes = Base64.decode64(id).bytes.to_a
      type = bytes[7] & 0xF0
      return type == 0x20
    end

    def is_agent? id
      bytes = Base64.decode64(id).bytes.to_a
      type = bytes[7] & 0xF0
      return type == 0x10
    end

    def used k, v
      abort "prov:entity is of wrong type:  #{v}." unless is_entity? v['prov:entity']
      abort "prov:activity is of wrong type: #{v}." unless is_activity? v['prov:activity']
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
