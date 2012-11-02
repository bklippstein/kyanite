# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'
require 'kyanite/general/object'
require 'kyanite/general/true_false'

# @!macro object
class TestKyaniteObject < UnitTest
  
 def test_is_numeric
   assert   1.2345.is_numeric?                  #=> 1.2345
   assert   12345678987654321.is_numeric?       #=> 1.23456789876543e+16
   assert   0.is_numeric?                       #=> 0.0
   assert   0.0.is_numeric?                     #=> 0.0
   assert   ".001".is_numeric?                  #=> 0.001
   assert   123435.12345.is_numeric?            #=> 123435.12345
   assert ! "123435.".is_numeric?               
   assert   "1.50130937545297e+68".is_numeric?  #=> 1.50130937545297e+68
   assert ! "a".is_numeric? 
   assert ! "a42".is_numeric? 
   assert ! "42a".is_numeric? 
   assert   123.42.is_numeric?                  #=> 123.42
   assert   "1_2_3.42".is_numeric?              #=> 123.42
   assert ! "_1_2_3_.42_".is_numeric? 
   assert ! "__1__2_3_.42__".is_numeric? 
   assert ! nil.is_numeric? 
   assert ! true.is_numeric? 
   assert ! false.is_numeric? 
   assert ! [].is_numeric? 
   assert ! [1].is_numeric? 
   assert ! [1,2].is_numeric? 
   assert ! Fixnum.is_numeric? 
 end     
 
 

  def test_blank
      #assert_equal true,      ''.blank?     # ok  
      # assert_equal false,     nil.blank?   
      assert_equal false,     1.blank?      # ok
      assert_equal false,     'a'.blank?    # ok
      assert_equal false,     true.blank?   # ok
      assert_equal false,     false.blank?  # ok
  end 

  

end # class 
