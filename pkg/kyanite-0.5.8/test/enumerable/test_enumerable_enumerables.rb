# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'kyanite/unit_test'
require 'kyanite/enumerable/enumerable_enumerables'

class Array
  include EnumerableEnumerables
end


# Tests für EnumerableEnumerables
# 
class TestKyaniteEnumerableEnumerables < UnitTest
  
  def test_rectangle1
    test = []
    test << [  :a,   :b,   :c  ]
    test << [   1,    2,    3  ]
    test << [ 'i', 'ii', 'iii' ]
    assert_equal test,              test.rectangle
    assert_equal test,              test.rectangle.rectangle
    assert_equal test.transpose,    test.rectangle.transpose.rectangle
  end
  
  
  
  def test_rectangle2
    test = []
    test << [  :a,   :b,   :c       ]
    test << [   1,    2,    3,   4  ]
    test << [ 'i', 'ii' ]
    
    expc = []
    expc << [  :a,   :b,   :c  ]
    expc << [   1,    2,    3  ]
    expc << [ 'i', 'ii', nil   ]    
    
    
    assert_equal expc,              test.rectangle
    assert_equal expc,              test.rectangle.rectangle
    assert_equal expc.transpose,    test.rectangle.transpose.rectangle
  end    

end # class 
