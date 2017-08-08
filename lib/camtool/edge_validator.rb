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
      abort "used prov:entity is of wrong type:  #{v}." unless is_entity? v['prov:entity']
      abort "used prov:activity is of wrong type: #{v}." unless is_activity? v['prov:activity']
    end

    def wasGeneratedBy k, v
      abort "wasGeneratedBy prov:entity is of wrong type:  #{v}." unless is_entity? v['prov:entity']
      abort "wasGeneratedBy prov:activity is of wrong type: #{v}." unless is_activity? v['prov:activity']
    end

    def wasDerivedFrom k, v
      abort "wasDerivedFrom prov:usedEntity is of wrong type:  #{v}." unless is_entity? v['prov:usedEntity']
      abort "wasDerivedFrom prov:generatedEntity is of wrong type: #{v}." unless is_entity? v['prov:generatedEntity']
    end

    def wasInformedBy k, v
      abort "wasInformedBy prov:informant is of wrong type:  #{v}." unless is_activity? v['prov:informant']
      abort "wasInformedBy prov:informed is of wrong type: #{v}." unless is_activity? v['prov:informed']
    end

    def wasAssociatedWith k, v
      abort "wasAssociatedWith prov:activity is of wrong type:  #{v}." unless is_activity? v['prov:activity']
      abort "wasAssociatedWith prov:agent is of wrong type: #{v}." unless is_agent? v['prov:agent']
    end
  end
end
