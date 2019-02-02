module CamTool
  class EdgeValidator < ValidatorUtils
    def initialize
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

    def relation k, v
      print_relation_bytes k
      puts v
      abort "relation should not be used"
    end
  end
end
