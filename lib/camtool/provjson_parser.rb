require 'json'

module CamTool
  class ProvJSONParser
    def read_json_file filename
      if filename != nil
        parse_json File.read(filename).gsub("\n", '') unless !File.file?(filename)
        print "File does not exist\n" unless File.file?(filename)
      end
      self
    end

    def read_log_file filename
      if filename != nil
        open(filename) do |file|
          file.each_line do |line|
            parse_json line.gsub("\n", '')
          end
        end unless !File.file?(filename)
        print "File does not exist\n" unless File.file?(filename)
      end
      self
    end

    def used k, v
    end

    def wasGeneratedBy k, v
    end

    def wasDerivedFrom k, v
    end

    def wasInformedBy k, v
    end

    def wasAssociatedWith k, v
    end

    def relation k, v
    end

    def prefix k, v
    end

    def entity k, v
    end

    def activity k, v
    end

    def agent k, v
    end

    def parse_json string
      begin
        json = JSON.parse(string)
      rescue JSON::ParserError => ex
        puts "Length: #{string.length}\n"
        abort "Error #{ex.class}, message: #{ex.message}"
      end

      json['prefix'].each do |k, v|
        self.prefix k, v
      end unless !json.key? 'prefix'

      json['entity'].each do |k, v|
        self.entity k, v
      end unless !json.key? 'entity'

      json['activity'].each do |k, v|
        self.activity k, v
      end unless !json.key? 'activity'

      json['agent'].each do |k, v|
        self.activity k, v
      end unless !json.key? 'agent'

      json['used'].each do |k, v|
        self.used k, v
      end unless !json.key? 'used'

      json['wasGeneratedBy'].each do |k, v|
        self.wasGeneratedBy k, v
      end unless !json.key? 'wasGeneratedBy'

      json['wasDerivedFrom'].each do |k, v|
        self.wasDerivedFrom k, v
      end unless !json.key? 'wasDerivedFrom'

      json['wasInformedBy'].each do |k, v|
        self.wasInformedBy k, v
      end unless !json.key? 'wasInformedBy'

      json['relation'].each do |k, v|
        self.relation k, v
      end unless !json.key? 'relation'

      json['wasAssociatedWith'].each do |k, v|
        self.wasAssociatedWith k, v
      end unless !json.key? 'wasAssociatedWith'
    end
  end
end
