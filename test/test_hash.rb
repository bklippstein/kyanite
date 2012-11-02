# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'                         
require 'kyanite/hash'

# @!macro hash
class TestKyaniteHash < UnitTest

  
  # Rubys +delete+ verändert den Hash!
  def test_delete
    h = {}
    assert_equal ({}),            h
    
    h[1] = 10
    assert_equal ({ 1 => 10 }),   h    

    assert_equal 10,              h.delete(1)
    assert_equal ({}),            h
  end 
  
  
  def test_compact
    dirty_hash = ({     :a => 1, 
                        :b => nil, 
                        :c => nil, 
                        :d => '', 
                        nil => 3    })
                       
              
    assert_equal 5, dirty_hash.size
    assert_equal 4, dirty_hash.dup.compact_keys!.size    
    assert_equal 3, dirty_hash.dup.compact_values!.size        
    
    dirty_hash.compact_keys!
    assert_equal 4, dirty_hash.size      
    
    dirty_hash.compact_values!
    assert_equal 2, dirty_hash.size   
  end 
  
  
  def test_slice
    dirty_hash = ({     :a => 1, 
                        :b => nil, 
                        :c => nil, 
                        :d => ''  })  
                        
    sliced = dirty_hash.slice(:b, :c)
    assert ! sliced.has_key?(:a)
    assert   sliced.has_key?(:b)
    assert   sliced.has_key?(:c)
    assert ! sliced.has_key?(:d)
    
  end
  

end # class 
