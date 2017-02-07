require 'json'

module CamFlow
  class LogBreaker
    def break_log_file filename
      if filename != nil
        open(filename) do |file|
          i=0
          file.each_line do |line|
            ok = true
            line = line.sub /\[[0-9 :-]*\]\t[A-Z]*[ ]*:[ ]*/, ''
            begin
              JSON.parse(line)
            rescue JSON::ParserError
              print line
              ok = false
            end
            if ok
              fname="/tmp/#{i}"
              i=i+1
              File.open(fname, 'w+') do |f|
                f.write line
              end
            end
          end
        end unless !File.file?(filename)
        print "File does not exist\n" unless File.file?(filename)
      end
      self
    end
  end
end
