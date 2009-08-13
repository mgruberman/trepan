require 'test/unit'
$: << File.expand_path(File.join(File.dirname(__FILE__),'..','ext'))
$: << File.expand_path(File.join(File.dirname(__FILE__),'..','lib'))
require 'trepan'

class Foo; end

class TestRoundTrip < Test::Unit::TestCase
  def test_nilroundtrip;    assert_equal( nil,     nil.__value__.__object__ ); end
  def test_trueroundtrip;   assert_equal( true,   true.__value__.__object__ ); end
  def test_falseroundtrip;  assert_equal( false, false.__value__.__object__ ); end
  def test_fixnumroundtrip; assert_equal( 42,       42.__value__.__object__ ); end
  def test_objroundtrip;
    o = Foo.new
    assert_equal( o, o.__value__.__object__ )
  end
end

# Local variables:
# mode: ruby
# End:
#
# vim: syntax=ruby
