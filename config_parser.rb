
class ConfigParser < Hash
  def initialize(filename)
    File.open(filename, "r").each_line do |line|
      line.gsub!(/#.*$/, '')

      if /^\s*(?<ident>\w+)\s*=\s*(?<value>.+?)\s*$/ =~ line
        self[ident] = case value
          when /^(on|yes|true)$/    then true
          when /^(off|no|false)$/   then false
          when /^\d+$/              then Integer(value)
          when /^\d+.\d*$/          then Float(value)
          else value
        end
      else
        STDERR.puts("Invalid line in config line #{$.}: #{line}")
      end
    end
  end
end
