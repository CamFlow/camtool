module CamTool
  class CheckPacket < ProvJSONParser
    def initialize
    end

    def entity k, v
      puts v['prov:label']+"\t"+v['cf:jiffies'] unless v['prov:type'] != 'packet'
    end
  end
end
