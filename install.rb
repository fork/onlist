require 'fileutils'

module Install

  TIME = Time.now
  ROOT = File.dirname __FILE__  
  rails_root = File.join ROOT, %w[ .. .. .. ]
  RAILS_ROOT = File.expand_path rails_root

  def copy(basename, target)
    source = File.join ROOT, 'install', basename
    target = File.join RAILS_ROOT, target

    begin
      FileUtils.mkdir_p target unless File.directory? target
      FileUtils.cp source, target, :verbose => true
    rescue
      STDERR.puts $!
      STDERR.puts "=> failed!"
    end
  end
  module_function :copy

end

STDERR.puts 'Onlist:'
STDERR.puts

Install.copy 'entry.rb', %w[app models onlist]

STDERR.puts
STDERR.puts 'Run script/generate onlist to create the migration.'
