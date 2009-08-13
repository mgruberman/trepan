require 'test/unit'
require 'trepan'

class TestTrepan < Test::Unit::TestCase

  RAISE_RB = File.expand_path(File.join(File.dirname(__FILE__),'raise.rb'))

  # === Description
  # Spawns a victim program which will run, go get semi-deep in a call
  # stack, then just hang out and wait to be killed by the test
  # harness.
  #
  def try_enhanced_caller

    # TODO: make this work without involving the shell. I tried using
    # getc, readpartial, read_nonblocking, read, and couldn't get any
    # to stop blocking. I'm sure there's an ordinary POSIX interface
    # in Ruby somewhere but I haven't found it yet.
    #
    # Am I supposed to just write C code when I want to have ordinary
    # POSIX?

    #rd, wr = IO.pipe
    #
    #pid = fork
    #if pid
    #  buf = ''
    #  while c = rd.getc
    #    buf += c
    #  end
    #  Process.waitpid( pid, 0 )
    #  return buf
    #else
    #  $stdout.reopen( wr )
    #  exec Trepan::RUBY, RAISE_RB
    #end

    `#{Trepan::RUBY} #{RAISE_RB}`
  end

  def test_enhanced_caller
    c = try_enhanced_caller
    assert_match( /
      \[\{:src=>".+:in\ `enhanced_caller'", \s+
          :args=>nil\}, \s+
         \{:src=>".+:in\ `d'", \s+
          :args=>\[10,\ 11,\ 12\]\}, \s+
         \{:src=>".+:in\ `c'", \s+
           :args=>\[6,\ 7,\ 8\]\}, \s+
         \{:src=>".+:9:in\ `b'", \s+
           :args=>\[3,\ 4,\ 5\]\}, \s+
         \{:src=>".+:in\ `a'", \s+
           :args=>\[1,\ 2,\ 3\]\}, \s+
         \{:src=>".+", \s+
           :args=>nil\}\]
      /x, c )
  end
  # TODO: Spawn a victim process which requests its own call stack
  # TODO: Is that call stack reasonable?
end

# Local variables:
# mode: ruby
# End:
#
# vim: syntax=ruby
