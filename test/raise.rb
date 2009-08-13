$: << File.expand_path(File.join(File.dirname(__FILE__),'..','ext'))
$: << File.expand_path(File.join(File.dirname(__FILE__),'..','lib'))

require 'trepan'
require 'pp'

def d(x,y,z); pp(enhanced_caller) end
def c(x,y,z); d(x+4,y+4,z+4); end
def b(x,y,z); c(x+3,y+3,z+3); end
def a(x,y,z); b(x+2,y+2,z+2); end
a(1,2,3)

# Local variables:
# mode: ruby
# End:
#
# vim: syntax=ruby
