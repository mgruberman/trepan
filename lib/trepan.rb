require 'rbconfig'
require 'reref'

module Kernel
  def enhanced_caller
    Trepan.enhanced_caller
  end
end

module Trepan
  # !!!: Duplicated in Rakefile
  VERSION = '1.0.0'

  # Construct the path to the ruby interpreter
  #
  RUBY   = File.join(
    Config::CONFIG['bindir'],
    "#{Config::CONFIG['ruby_install_name']}#{Config::CONFIG['EXEEXT']}"
  )

  # Construct the path the trepan program
  #
  TREPAN = File.join( Config::CONFIG['bindir'], 'trepan-backend' )

  # === Description
  # TODO: description goes here
  #
  # === Returns
  # TODO: description goes here
  #
  def enhanced_caller

    # Disable GC for a moment so I won't suffer a bad pointer while
    # I'm plucking objects right out of memory.
    #
    gc_was_disabled = GC.disable

    # Open my own brain for inspection. This is going to produce a
    # bunch of data like:
    #
    #   VALUE[0][0] = 85
    #   VALUE[0][1] = ...
    #
    my_brain = `#{ruby} #{trepane_rb} #{$$}`


    # Reach into our memory and pluck some objects out.
    #
    caller_argv = []
    my_brain.scan( /VALUE\[(\d+)\]\[(\d+)\]=(\d+)/ ) do
      | match |

      caller_ix = match[0].to_i
      argv_ix   = match[1].to_i
      pointer   = match[2].to_i

      caller_argv[caller_ix] ||= []
      caller_argv[argv_ix] = pointer.__object__
    end

    # Re-enable GC if relevant because I've finished capturing
    # everything
    #
    if gc_was_disabled
      GC.enable
    end

    # The top level of caller_argv ought to have the Kernel.`...`
    # function call so remove it.
    #
    stack = Kernel.caller
    while caller_argv.length > stack.length
      caller_argv.shift
    end

    # Make the enhanced caller results
    #
    stack.
      zip( caller_argv )\
      .collect do
        | src, args |
        {
          :src => src,
          :args => args
        }
      end
  end
end

# Local variables:
# mode: ruby
# End:
#
# vim: syntax=ruby
