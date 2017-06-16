require 'mqtt'
require 'zlib'
require 'base64'

module CamTool
  class MQTTBreaker < LogBreaker
    def initialize
      conn_opts = {
        remote_host: 'm12.cloudmqtt.com',
        remote_port: 17065,
        username: 'camflow',
        password: 'test',
      }
      @c = MQTT::Client.connect conn_opts
    end

    def new_entry entry
      comp = Zlib::Deflate.deflate entry
      ready = Base64.encode64 comp
      @c.publish 'camflow/test', ready
      sleep 5
    end
  end
end
