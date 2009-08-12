require 'trepan'

class Exception
  def initialize
    @trepan = Trepan.enhanced_caller
    super
  end
  def backtrace
    @trepan\
      .collect {
        |elt|

        src  = elt[:src]
        args = elt[:args]\
          .collect { |a| a.to_s }\
          .join( ',' )
      "#{src}(#{args})"
    }
  end
end

# Local variables:
# mode: ruby
# End:
#
# vim: syntax=ruby
