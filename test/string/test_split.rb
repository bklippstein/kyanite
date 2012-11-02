# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'
require 'kyanite/string/split'



# Tests for String
# @!macro string
class TestKyaniteStringSplit < UnitTest
    
  def test_nchar
     assert_equal 'a',      'abcde'.nchar(1)    
     assert_equal 'ab',     'abcde'.nchar(2) 
     assert_equal 'abc',    'abcde'.nchar(3) 
     assert_equal 'abcd',   'abcde'.nchar(4) 
     assert_equal 'abcde',  'abcde'.nchar(5) 
     assert_equal 'abcde',  'abcde'.nchar(6) 
     
     assert_equal '',       'abcde'.nchar(0)    
     assert_equal 'e',      'abcde'.nchar(-1)      
     assert_equal 'de',     'abcde'.nchar(-2)      
     assert_equal 'cde',    'abcde'.nchar(-3)      
     assert_equal 'bcde',   'abcde'.nchar(-4)      
     assert_equal 'abcde',  'abcde'.nchar(-5)      
     assert_equal 'abcde',  'abcde'.nchar(-6)     

     assert_equal 'abcde',  'abcde'.nchar(0,'')    
     assert_equal 'bcde',   'abcde'.nchar(1,'')    
     assert_equal 'cde',    'abcde'.nchar(2,'') 
     assert_equal 'de',     'abcde'.nchar(3,'') 
     assert_equal 'e',      'abcde'.nchar(4,'') 
     assert_equal '',       'abcde'.nchar(5,'') 
     assert_equal '',       'abcde'.nchar(6,'')   

     assert_equal 'abcde',  'abcde'.nchar(0,'')    
     assert_equal 'abcd',   'abcde'.nchar(-1,'')    
     assert_equal 'abc',    'abcde'.nchar(-2,'') 
     assert_equal 'ab',     'abcde'.nchar(-3,'') 
     assert_equal 'a',      'abcde'.nchar(-4,'') 
     assert_equal '',       'abcde'.nchar(-5,'') 
     assert_equal '',       'abcde'.nchar(-6,'')         
  end
  
    
  
  def test_split_by_index
     assert_equal ['', 'abcde'],     'abcde'.split_by_index(0)   
     assert_equal ['a', 'bcde'],     'abcde'.split_by_index(1)    
     assert_equal ['ab', 'cde'],     'abcde'.split_by_index(2)    
     assert_equal ['abc', 'de'],     'abcde'.split_by_index(3)    
     assert_equal ['abcd', 'e'],     'abcde'.split_by_index(4)    
     assert_equal ['abcde', ''],     'abcde'.split_by_index(5)    
     assert_equal ['abcde', ''],     'abcde'.split_by_index(6)    
     assert_equal ['abcde', ''],     'abcde'.split_by_index(1000)    
      
     assert_equal ['', 'abcde'],     'abcde'.split_by_index(0)         
     assert_equal ['e', 'abcd'],     'abcde'.split_by_index(-1)    
     assert_equal ['de', 'abc'],     'abcde'.split_by_index(-2)    
     assert_equal ['cde', 'ab'],     'abcde'.split_by_index(-3)    
     assert_equal ['bcde', 'a'],     'abcde'.split_by_index(-4)    
     assert_equal ['abcde', ''],     'abcde'.split_by_index(-5)    
     assert_equal ['abcde', ''],     'abcde'.split_by_index(-100)    
     
     assert_equal ['', '', 'abcde'],  'abcde'.split_by_index([0,0])      
     assert_equal ['', 'a', 'bcde'],  'abcde'.split_by_index([0,1])      
     assert_equal ['', 'ab', 'cde'],  'abcde'.split_by_index([0,2])      
     assert_equal ['', 'abc', 'de'],  'abcde'.split_by_index([0,3])      
     assert_equal ['', 'abcd', 'e'],  'abcde'.split_by_index([0,4])      
     assert_equal ['', 'abcde', ''],  'abcde'.split_by_index([0,5])       
     assert_equal ['', 'abcde', ''],  'abcde'.split_by_index([0,100])       
     
     assert_equal ['a', '', 'bcde'],  'abcde'.split_by_index([1,0])      
     assert_equal ['a', 'b', 'cde'],  'abcde'.split_by_index([1,1])      
     assert_equal ['a', 'bc', 'de'],  'abcde'.split_by_index([1,2])      
     assert_equal ['a', 'bcd', 'e'],  'abcde'.split_by_index([1,3])      
     assert_equal ['a', 'bcde', ''],  'abcde'.split_by_index([1,4])           
     assert_equal ['a', 'bcde', ''],  'abcde'.split_by_index([1,100])      
     
     assert_equal ['ab', '', 'cde'],  'abcde'.split_by_index([2,0])      
     assert_equal ['ab', 'c', 'de'],  'abcde'.split_by_index([2,1])      
     assert_equal ['ab', 'cd', 'e'],  'abcde'.split_by_index([2,2])      
     assert_equal ['ab', 'cde', ''],  'abcde'.split_by_index([2,3])      
     assert_equal ['ab', 'cde', ''],  'abcde'.split_by_index([2,100])      
     
     assert_equal ['', '', '', 'abcde'],  'abcde'.split_by_index([0,0,0])        
     assert_equal ['', 'abcde', '', ''],  'abcde'.split_by_index([0,100,0])        
     assert_equal ['', '', 'abcde', ''],  'abcde'.split_by_index([0,0,100])        
  end  
  
  
  def test_cut
  	assert_equal 'Hal', 'Hallo'.cut(3)
  	assert_equal 'Hallo', 'Hallo'.cut(5)
  	assert_equal 'Hallo', 'Hallo'.cut(99)
  	
  	assert_equal '', 'Hallo'.cut(0)
  	assert_equal '', ''.cut(0)
  	assert_equal '', ''.cut(99)
  	assert_equal '', nil.cut(0)
  	assert_equal '', nil.cut(5)
  end  
  
  
  def test_extract
  	string = '<select id="hello"><option value="0">none</option></select>'
  	assert_equal 'hello', string.extract(  /select.*?id="/  ,  '"'  )
  end    
  
  
  def test_fixsize
    test = 'Hallo'
    0.upto(10) do |i|
      assert_equal i,    test.fixsize(i).size
    end
    -10.upto(0) do |i|
      assert_equal 0,    test.fixsize(i).size
    end
  end
    
    
  def test_split_numeric
    assert_equal nil,                 nil.split_numeric
    assert_equal ['abc',123],         'abc123'.split_numeric
    assert_equal [' abc',123],        ' abc123'.split_numeric
    assert_equal ['abc ',123],        'abc 123'.split_numeric
    assert_equal [123,'abc'],         '123abc'.split_numeric
    assert_equal [123,'abc '],        '123abc '.split_numeric
    assert_equal [123,' abc'],        '123 abc'.split_numeric
    
    assert_equal 123,                 '123'.split_numeric
    assert_equal 'abc',               'abc'.split_numeric
    
    assert_equal [123,'abc',456],     '123abc456'.split_numeric    
    assert_equal ['abc',123,'def'],   'abc123def'.split_numeric 
  end    
  
  
  def test_without_versioninfo
    assert_equal 'Hallo',   'Hallo_123.23'.without_versioninfo
    assert_equal 'Hallo',   'Hallo-123.23'.without_versioninfo
    assert_equal 'Hallo',   'Hallo 123.23'.without_versioninfo
    assert_equal 'Hallo',   'Hallo123.23'.without_versioninfo
    assert_equal 'Hallo',   'Hallo123_23'.without_versioninfo
    assert_equal 'Hallo',   'Hallo.123_23'.without_versioninfo
    assert_equal 'Hallo-Welt',   'Hallo-Welt_123.23'.without_versioninfo
    assert_equal 'Hallo-Welt',   'Hallo-Welt-123.23'.without_versioninfo
    assert_equal 'Hallo-Welt',   'Hallo-Welt 123.23'.without_versioninfo
    assert_equal 'Hallo-Welt',   'Hallo-Welt123.23'.without_versioninfo
    assert_equal 'Hallo-Welt',   'Hallo-Welt123_23'.without_versioninfo    
    assert_equal 'Hallo-Welt',   'Hallo-Welt.123_23'.without_versioninfo    
    assert_equal 'Hallo_Baum',   'Hallo_Baum_123.23'.without_versioninfo
    assert_equal 'Hallo_Baum',   'Hallo_Baum-123.23'.without_versioninfo
    assert_equal 'Hallo_Baum',   'Hallo_Baum 123.23'.without_versioninfo
    assert_equal 'Hallo_Baum',   'Hallo_Baum123.23'.without_versioninfo
    assert_equal 'Hallo_Baum',   'Hallo_Baum123_23'.without_versioninfo    
    assert_equal 'Hallo_Baum',   'Hallo_Baum.123_23'.without_versioninfo 
  end    
    
    
end # class

































