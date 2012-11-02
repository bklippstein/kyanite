# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'
require 'kyanite/array'
require 'kyanite/numeric/numeric'
require 'kyanite/set' 


# @!macro array
class TestKyaniteArray < UnitTest 
  
  def test_rephrase_index
    test = [ :a, :b, :c, :d]
    0.upto(3) do | i |
      i_inv = test.rephrase_index(i)
      i_neg = test.rephrase_index(i, :neg)
      i_pos = test.rephrase_index(i, :pos)
      # print "\n#{test[i]}   #{i}   #{i_inv}"
      
      assert_not_equal  i,      i_inv    
      assert_not_equal  i,      i_neg    
      assert_equal      i_neg,  i_inv    
      assert_equal      i,      i_pos   
      assert_equal test[i],   test[i_inv]
      assert_equal test[i],   test[i_pos]
      assert_equal test[i],   test[i_neg]
    end # do
    
    -4.upto(-1) do | i |
      i_inv = test.rephrase_index(i)
      i_neg = test.rephrase_index(i, :neg)
      i_pos = test.rephrase_index(i, :pos)
      # print "\n#{test[i]}   #{i}   #{i_inv}"
      
      assert_not_equal  i,      i_inv    
      assert_not_equal  i,      i_pos    
      assert_equal      i_pos,  i_inv    
      assert_equal      i,      i_neg   
      assert_equal test[i],   test[i_inv]
      assert_equal test[i],   test[i_pos]
      assert_equal test[i],   test[i_neg]
    end # do    
    
    [4, 5, -5, -6].each do |i|
      i_inv = test.rephrase_index(i)
      i_neg = test.rephrase_index(i, :neg)
      i_pos = test.rephrase_index(i, :pos)
      # print "\nx   #{i}   #{i_inv}"  
      assert_equal      i,      i_neg         
      assert_equal      i,      i_pos         
      assert_equal      i,      i_neg         
      assert_equal test[i],   test[i_inv]
      assert_equal test[i],   test[i_pos]
      assert_equal test[i],   test[i_neg]    
    end
    
  end
  
  

  
  def test_array_diff
      a = [1,2,3,4,5, :a, 'b']
      b = [1,2,4,5,6,'a',:c]

      assert_equal [3,:a,'b'],                a - b                
      assert_equal [3,:a,'b', 3,:a,'b'],      a + a - b             
      assert_equal [6, 'a', :c],              b - a
      assert_equal [],                        b - b
      assert_equal [],                        a - a
  end


  def test_array_shift_complement
      assert_equal [2,3],   [1,2,3].shift_complement
      assert_equal 3,       [1,2,3].shift_complement.shift_complement
      assert_equal nil,     [1,2,3].shift_complement.shift_complement.shift_complement
  end


  
 
  
    
  

  
  
  
end # class 









