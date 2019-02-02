module CamTool
  class ValidatorUtils < ProvJSONParser
    def initialize
    end

    def is_relation? id
      id = id.gsub 'cf:', ''
      bytes = Base64.decode64(id).bytes.to_a
      type = bytes[7] & 0xF0
      return type == 0x80
    end

    def is_activity? id
      id = id.gsub 'cf:', ''
      bytes = Base64.decode64(id).bytes.to_a
      type = bytes[7] & 0xF0
      return type == 0x40
    end

    def is_entity? id
      id = id.gsub 'cf:', ''
      bytes = Base64.decode64(id).bytes.to_a
      type = bytes[7] & 0xF0
      return type == 0x20
    end

    def is_agent? id
      id = id.gsub 'cf:', ''
      bytes = Base64.decode64(id).bytes.to_a
      type = bytes[7] & 0xF0
      return type == 0x10
    end
  end
end
