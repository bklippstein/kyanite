# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'                
require 'kyanite/dictionary'


# @!macro dictionary
class TestKyaniteDictionary < UnitTest

    def test_is_collection
      assert Dictionary[1,2,3,4].is_collection?
    end
    
    
    def test_to_dictionary
      test = {  :a => 1, 
                :b => 2,
                :c => 3  }
      dict = test.to_dictionary
      assert_equal 3,    dict.size
      assert_equal 1,    dict[:a]
      assert_equal 2,    dict[:b]
      assert_equal 3,    dict[:c]
    end
    

    
    
    def test_each
      test = Dictionary[ 'a', 1, 'b', 2, 'c', 3 ]
      test.each do | k, v|
        assert_equal String, k.class
        assert_equal Fixnum, v.class
      end
      
      test.each_with_index do | k, v, i|
        assert_equal String, k.class
        assert_equal Fixnum, v.class
        assert_equal Fixnum, i.class
      end
        
    end

    
    def test_create 
      hsh = Dictionary['z', 1, 'a', 2, 'c', 3] 
      assert_equal( ['z','a','c'], hsh.keys )
    end

    
    def test_op_store
      hsh = Dictionary.new
      hsh['z'] = 1
      hsh['a'] = 2
      hsh['c'] = 3
      assert_equal( ['z','a','c'], hsh.keys )
    end

    
    def test_push
      hsh = Dictionary['a', 1, 'c', 2, 'z', 3]
      assert( hsh.push('end', 15) )
      assert_equal( 15, hsh['end'] )
      assert( ! hsh.push('end', 30) )
      assert( hsh.unshift('begin', 50) )
      assert_equal( 50, hsh['begin'] )
      assert( ! hsh.unshift('begin', 60) )
      assert_equal( ["begin", "a", "c", "z", "end"], hsh.keys )
      assert_equal( ["end", 15], hsh.pop )
      assert_equal( ["begin", "a", "c", "z"], hsh.keys )
      assert_equal( ["begin", 50], hsh.shift )
    end

    
    def test_insert
      # front
      h = Dictionary['a', 1, 'b', 2, 'c', 3]
      r = Dictionary['d', 4, 'a', 1, 'b', 2, 'c', 3]
      assert_equal( 4, h.insert(0,'d',4) )
      assert_equal( r, h )
      # back
      h = Dictionary['a', 1, 'b', 2, 'c', 3]
      r = Dictionary['a', 1, 'b', 2, 'c', 3, 'd', 4]
      assert_equal( 4, h.insert(-1,'d',4) )
      assert_equal( r, h )
    end

    
    def test_update
      # with other orderred hash
      h1 = Dictionary['a', 1, 'b', 2, 'c', 3]
      h2 = Dictionary['d', 4]
      r = Dictionary['a', 1, 'b', 2, 'c', 3, 'd', 4]
      assert_equal( r, h1.update(h2) )
      assert_equal( r, h1 )
      # with other hash
      h1 = Dictionary['a', 1, 'b', 2, 'c', 3]
      h2 = { 'd' => 4 }
      r = Dictionary['a', 1, 'b', 2, 'c', 3, 'd', 4]
      assert_equal( r, h1.update(h2) )
      assert_equal( r, h1 )
    end

    
    def test_merge
      # with other orderred hash
      h1 = Dictionary['a', 1, 'b', 2, 'c', 3]
      h2 = Dictionary['d', 4]
      r = Dictionary['a', 1, 'b', 2, 'c', 3, 'd', 4]
      assert_equal( r, h1.merge(h2) )
      # with other hash
      h1 = Dictionary['a', 1, 'b', 2, 'c', 3]
      h2 = { 'd' => 4 }
      r = Dictionary['a', 1, 'b', 2, 'c', 3, 'd', 4]
      assert_equal( r, h1.merge(h2) )
    end

    
    def test_order_by
      h1 = Dictionary['a', 3, 'b', 2, 'c', 1]
      h1.order_by{ |k,v| v }
      assert_equal( [1,2,3], h1.values )
      assert_equal( ['c','b','a'], h1.keys )
    end

end


