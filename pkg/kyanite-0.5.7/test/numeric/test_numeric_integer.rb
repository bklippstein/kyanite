# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'kyanite/unit_test'
require 'kyanite/numeric'

# Tests for Numeric
class TestKyaniteNumeric < UnitTest

  # ---------------------------------------------------------------------------------------------------------------------------------
  # :section: Integer
  #       
  
  # Tests for Integer  
  def test_integer_triviales
    a = 1
    assert_equal Fixnum,  a.class
    assert_equal 1,       a.to_integer
    assert_equal 1,       a.to_integer_optional
    assert_equal 1,       a.dup
    
    a = 11111111111111111111111111111111111    
    assert_equal Bignum,  a.class
    assert_equal 11111111111111111111111111111111111,       a.to_integer
    assert_equal 11111111111111111111111111111111111,       a.to_integer_optional
    assert_equal 11111111111111111111111111111111111,       a.dup     
  end
  
end # class 
