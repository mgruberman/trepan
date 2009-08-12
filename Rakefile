require 'rubygems'
require 'hoe'
require 'rbconfig'

EXT = "ext/reref.#{Config::CONFIG['DLEXT']}"

class Trepan
  # !!!: Duplicated in lib/trepan.rb
  VERSION = '1.0.0'
end

Hoe.spec 'trepan' do
  | p |

  # self.rubyforge_name = 'trepanx' # if different than 'trepan'
  
  p.spec_extras[:extensions] = 'ext/extconf.rb'
  p.clean_globs << EXT << 'ext/*.o' << 'ext/Makefile'

  p.developer('Josh ben Jore', 'twists@gmail.com')
end

task :test => EXT

file EXT => [ 'ext/extconf.rb', 'ext/reref.c' ] do
  Dir.chdir( 'ext' ) do
    ruby 'extconf.rb'
    sh 'make'
  end
end

# Local variables:
# mode: ruby
# End:
#
# vim: syntax=ruby
