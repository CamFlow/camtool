module CamTool
  class CheckPacket < ProvJSONParser
    def initialize
    end

    def entity k, v
      puts v['cf:jiffies']+"\t"+v['prov:label'] unless v['prov:type'] != 'packet'
    end
  end
end
