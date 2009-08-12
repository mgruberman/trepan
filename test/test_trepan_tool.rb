require 'test/unit'
require 'trepan'

class TestTrepanTool < Test::Unit::TestCase

  # === Description
  # Spawns a victim program which will run, go get semi-deep in a call
  # stack, then just hang out and wait to be killed by the test
  # harness.
  #
  def spawn_victim_program
    pid = fork
    if pid
      @victim_pid = pid
    else
      exec Trepan::RUBY, '-e', <<-'VICTIM'
        def d(x,y,z); sleep 1; end
        def c(x,y,z); d(x+4,y+4,z+4); end
        def b(x,y,z); c(x+3,y+3,z+3); end
        def a(x,y,z); b(x+2,y+2,z+2); end
        Signal.trap( 'INT' ) { exit }
        a(1,2,3)
      VICTIM
    end
  end

  # === Description
  # Kills the victim program.
  #
  def kill_victim_program
    Process.kill( 'INT', @victim_pid )
    Process.waitpid( @victim_pid, 0 )
  end

  # === Description
  # Inspect the victim.
  #
  def inspect_victim
    `#{Trepan::RUBY} #{File.expand_path(File.join(File.dirname(__FILE__),'../bin/trepan-backend'))} #{@victim_pid}`
  end

  # === Description
  # Test that inspecting a victim produces the right call stack
  #
  def test_inspection
    spawn_victim_program
    inspection = inspect_victim
    assert_match( /^
      VALUE\[0\]\[0\]=\d+ \n
      VALUE\[1\]\[0\]=\d+ \n
      VALUE\[1\]\[1\]=\d+ \n
      VALUE\[1\]\[2\]=\d+ \n
      VALUE\[2\]\[0\]=\d+ \n
      VALUE\[2\]\[1\]=\d+ \n
      VALUE\[2\]\[2\]=\d+ \n
      VALUE\[3\]\[0\]=\d+ \n
      VALUE\[3\]\[1\]=\d+ \n
      VALUE\[3\]\[2\]=\d+ \n
      VALUE\[4\]\[0\]=\d+ \n
      VALUE\[4\]\[1\]=\d+ \n
      VALUE\[4\]\[2\]=\d+ \n /x, inspection )
    kill_victim_program
  end
end

# Local variables:
# mode: ruby
# End:
#
# vim: syntax=ruby
