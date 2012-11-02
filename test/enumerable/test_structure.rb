# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'
require 'kyanite/enumerable/structure'
#require 'kyanite/dictionary'
require 'kyanite/set'
#require 'kyanite/hash'



# @!macro enumerable
class TestKyaniteEnumerableStructure < UnitTest

 def test_is_collection
 
    # keine Collection
    assert ! 123.is_collection?
    assert ! (123.4).is_collection?
    assert ! (123.4).is_collection?
    assert ! (:hallo).is_collection?
    assert ! ''.is_collection?
    assert ! /123/.is_collection?
    assert ! Time.now.is_collection?
    assert ! nil.is_collection?
    assert ! true.is_collection?
    assert ! false.is_collection?
    assert ! Array.is_collection?
    assert ! (1..4).is_collection?     # Range gilt NICHT als Collection
 
    # Collections
    assert [1,2,3].is_collection?
    assert [1].is_collection?
    assert [].is_collection?
    assert ['1','2','3'].is_collection?
    assert ({}).is_collection?
    assert ({:a => '1', :b => '2'}).is_collection?
    assert Dictionary[1,2,3,4].is_collection?
    
    Struct.new("Customer", :name, :adress)
    struct = Struct::Customer.new("Dave", "123 main")
    assert struct.is_collection?
    
  end # test_is_collection?  
  
  
  

 
  def test_distribution_size
    test = []
    test << [  :a,   :b,   :c       ]
    test << [   1,    2,    3,   4  ]
    test << [ 'i', 'ii' ]
    expected = [[2,   1],
                [3,   1],
                [4,   1]]
    assert_equal expected,  test.distribution
    
    test = []
    test << [  :a,   :b,   :c  ]
    test << [   1,    2,    3  ]
    test << [ 'i', 'ii', nil   ]    
    assert_equal [[3, 3]],        test.distribution   

    test = [  :a,   :bbbbbb,   :c  ] 
    assert_equal [[1, 2], [6, 1]],  test.distribution
  end    
  
  
  
  def test_distribution_class
    test = []
    test << [  :a,   :b,   :c       ]
    test << [   1,    2,    3,   4  ]
    test << [ 'i', 'ii' ]
    assert_equal [[Array, 3]],  test.distribution(:class)
    
    test = [  :a,   :b,   :c  ] 
    assert_equal [[Symbol, 3]],  test.distribution(:class)  
    
    test = []
    test << [  :a,   :b,   :c  ]
    test << Set.new([   1,    2,    3  ])
    test << [ 'i', 'ii', nil   ]    
    assert_equal [[Array, 2], [Set, 1]],  test.distribution(:class)       
  end    



  def test_contentclass_mono
    test = [  :a,   :b,   :c   ]
    assert_equal Symbol, test.contentclass
    assert_equal Symbol, test.contentclass( :precision => 1 )
    assert_equal Symbol, test.contentclass( :precision => 2 )
    assert_equal Symbol, test.contentclass( :precision => :all )
    
    test = [   1,    2,    3,   4  ]
    assert_equal Fixnum, test.contentclass
    assert_equal Fixnum, test.contentclass( :precision => 1 )
    assert_equal Fixnum, test.contentclass( :precision => 2 )
    assert_equal Fixnum, test.contentclass( :precision => :all )    
    
    
    test = [ 'i', 'ii' ]  
    assert_equal String, test.contentclass
    assert_equal String, test.contentclass( :precision => 1 )
    assert_equal String, test.contentclass( :precision => 2 )
    assert_equal String, test.contentclass( :precision => :all )      
  end
  
  
  def test_contentclass_multi 
    test = [   1,    2,    3,   4.0  ]
    assert_equal Numeric, test.contentclass
    assert_equal Fixnum,  test.contentclass( :precision => 1 )
    assert_equal Numeric, test.contentclass( :precision => 2 )
    assert_equal Numeric, test.contentclass( :precision => :all )    
    
    test = [   1,    2,    3,   4.0,    5   ]
    assert_equal Fixnum,  test.contentclass
    assert_equal Fixnum,  test.contentclass( :precision => 1 )
    assert_equal Fixnum,  test.contentclass( :precision => 2 )
    assert_equal Numeric, test.contentclass( :precision => :all )     
    
    test = [   nil, 1,    2,    3,   4.0,    5   ]
    assert_equal Fixnum,  test.contentclass
    assert_equal Fixnum,  test.contentclass( :precision => 1 )
    assert_equal Fixnum,  test.contentclass( :precision => 2 )
    assert_equal Numeric, test.contentclass( :precision => :all )    

    test = [   1,    2,    3,   4.0,    5,  nil   ]
    assert_equal Fixnum,  test.contentclass
    assert_equal Fixnum,  test.contentclass( :precision => 1 )
    assert_equal Fixnum,  test.contentclass( :precision => 2 )
    assert_equal Numeric, test.contentclass( :precision => :all )      

    test = [   nil, 1,    2,    3,   4.0,    5   ]
    assert_equal Fixnum,    test.contentclass
    assert_equal NilClass,  test.contentclass( :precision => 1,     :ignore_nil => false )
    assert_equal Object,    test.contentclass( :precision => 2,     :ignore_nil => false )
    assert_equal Object,    test.contentclass( :precision => :all,  :ignore_nil => false )      


    test = [ nil ]
    assert_equal nil,       test.contentclass
    assert_equal nil,       test.contentclass( :precision => 1 )
    assert_equal nil,       test.contentclass( :precision => 2 )
    assert_equal nil,       test.contentclass( :precision => :all )       
    
    test = [ ]
    assert_equal nil,       test.contentclass
    assert_equal nil,       test.contentclass( :precision => 1 )
    assert_equal nil,       test.contentclass( :precision => 2 )
    assert_equal nil,       test.contentclass( :precision => :all )      
    
    test = [ nil ]
    assert_equal NilClass,  test.contentclass( :ignore_nil => false )
    assert_equal NilClass,  test.contentclass( :precision => 1,     :ignore_nil => false )
    assert_equal NilClass,  test.contentclass( :precision => 2,     :ignore_nil => false )
    assert_equal NilClass,  test.contentclass( :precision => :all,  :ignore_nil => false )        
    
  end  
  
  def test_contentclass_set_and_hash
    test = SortedSet.new([   1,    2,    3,   4.0  ])
    assert_equal Numeric, test.contentclass
    assert_equal Fixnum,  test.contentclass( :precision => 1 )
    assert_equal Numeric, test.contentclass( :precision => 2 )
    assert_equal Numeric, test.contentclass( :precision => :all )      

    test = OrderedSet.new([   1,    2,    3,   4.0  ])
    assert_equal Numeric, test.contentclass
    assert_equal Fixnum,  test.contentclass( :precision => 1 )
    assert_equal Numeric, test.contentclass( :precision => 2 )
    assert_equal Numeric, test.contentclass( :precision => :all )    

    test = Set.new([   1,    2,    3,   4  ])
    assert_equal Fixnum,  test.contentclass
    assert_equal Fixnum,  test.contentclass( :precision => 1 )
    assert_equal Fixnum,  test.contentclass( :precision => 2 )
    assert_equal Fixnum,  test.contentclass( :precision => :all )      
    
    test = {:b => 2, :a => 1,  :c => 3}
    assert_equal Fixnum,  test.contentclass
    assert_equal Fixnum,  test.contentclass( :precision => 1 )
    assert_equal Fixnum,  test.contentclass( :precision => 2 )
    assert_equal Fixnum,  test.contentclass( :precision => :all )  

    test = Dictionary[ 'a', 1, 'b', 2, 'c', 3 ]
    assert_equal Fixnum,  test.contentclass
    assert_equal Fixnum,  test.contentclass( :precision => 1 )
    assert_equal Fixnum,  test.contentclass( :precision => 2 )
    assert_equal Fixnum,  test.contentclass( :precision => :all )    

    test = Dictionary[ 'a', 1, 'b', 2, 'c', 3.0 ]
    assert_equal Numeric,  test.contentclass
    assert_equal Fixnum,   test.contentclass( :precision => 1 )
    assert_equal Numeric,  test.contentclass( :precision => 2 )
    assert_equal Numeric,  test.contentclass( :precision => :all )      
    
  end      
  
  
  

end # class 











