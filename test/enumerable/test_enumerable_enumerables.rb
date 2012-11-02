# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
  require 'perception'
end
require 'drumherum/unit_test'
require 'kyanite/enumerable/enumerable_enumerables'


# @!macro enum_of_enums
class TestKyaniteEnumerableEnumerables < UnitTest
  
  def test_rectangle1
    test = ArrayOfEnumerables.new
    test << [  :a,   :b,   :c  ]
    test << [   1,    2,    3  ]
    test << [ 'i', 'ii', 'iii' ]
    
    assert_equal test,              test.rectangle
    assert_equal test,              test.rectangle.rectangle
    assert_equal test.transpose,    test.rectangle.transpose.to_array_of_enumerables.rectangle
  end
  
  
  
  def test_rectangle2
    test = ArrayOfEnumerables.new
    test << [  :a,   :b,   :c       ]
    test << [   1,    2,    3,   4  ]
    test << [ 'i', 'ii' ]
    
    expc = ArrayOfEnumerables.new
    expc << [  :a,   :b,   :c  ]
    expc << [   1,    2,    3  ]
    expc << [ 'i', 'ii', nil   ]    
    
    
    assert_equal expc,              test.rectangle
    assert_equal expc,              test.rectangle.rectangle
    assert_equal expc.transpose,    test.rectangle.transpose.to_array_of_enumerables.rectangle
  end    

end # class 
