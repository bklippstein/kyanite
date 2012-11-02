# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'
require 'kyanite/numeric'


# @!macro numeric
class TestKyaniteNumeric < UnitTest

  # ---------------------------------------------------------------------------------------------------------------------------------
  # @!group Integer
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
