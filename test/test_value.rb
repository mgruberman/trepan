require 'test/unit'
require 'trepan'

class TestValues < Test::Unit::TestCase
  def   test_nilobj; assert_equal(   nil.object_id,   nil.__value__ ); end
  def  test_trueobj; assert_equal(  true.object_id,  true.__value__ ); end
  def test_falseobj; assert_equal( false.object_id, false.__value__ ); end
end

# Local variables:
# mode: ruby
# End:
#
# vim: syntax=ruby
