# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
  require 'perception'  
end
require 'drumherum/unit_test' 

require 'kyanite/fsymbol'              


# @!macro fsymbol
class TestKyaniteFSymbols < UnitTest

  
  def setup
  
    unless defined? $def_tree
        # Oberste Ebene
        ttroot = Tree::TreeNode.new(:root)
        ttroot << Tree::TreeNode.new(:item)       
        ttroot << Tree::TreeNode.new(:num) 
        ttroot << Tree::TreeNode.new(:site) << Tree::TreeNode.new(:url) 
        ttroot << Tree::TreeNode.new(:sonstiges) 
        
        # :singlechar
        ttroot << Tree::TreeNode.new(:singlechar)        
                              ttroot[:singlechar] << Tree::TreeNode.new(:struktur) << Tree::TreeNode.new(:punkt) << Tree::TreeNode.new(:satzende) 
                              ttroot[:singlechar] << Tree::TreeNode.new(:minus) 
                              ttroot[:singlechar] << Tree::TreeNode.new(:sonderzeichen)  
        
       # :item    
        ttroot[:item] << (wa_word=Tree::TreeNode.new(:de)) << Tree::TreeNode.new(:name)    
                            wa_word << Tree::TreeNode.new(:abbrev)   
                            wa_word << Tree::TreeNode.new(:multi)   
        
        
        $def_tree = ttroot   
        #$def_tree.print_tree     
    end    
  
    @tokencodes = [:num, :url, :site, :item, :punkt, :minus, :struktur, :sonderzeichen, :sonstiges, :singlechar, :satzende, :de, :abbrev, :name, :multi]
    @root = :root.to_fsymbol($def_tree)
  end
  
  
  
  def test_first
    a = FSymbol.new(:item)
    assert_equal 'item',     a.to_s
    assert_equal ':item',    a.inspect
  end    
  
  
  def test_raise
    assert_raise(ArgumentError)  {   FSymbol.new(:idfsdgtem)  }
    assert_raise(ArgumentError)  {   FSymbol.new('item')  }
    assert_raise(ArgumentError)  {   FSymbol.new(nil)  }
  end     

    
  def test_tokencodes
    @tokencodes.each do |c|
      assert_equal c.to_s,  FSymbol.new(c).to_s, "FSymbol für Tokencode :#{c} konnte nicht erzeugt werden"          
    end
  end

  
  def test_all_child_keys
    t = @tokencodes.to_set
    b = FSymbol.new(:root).childs.to_set
    diff = ((t-b) + (b-t)).to_a
    assert_equal t, b, "\n\n\nDifferenz zwischen @tokencodes hier im Test und dem Definitionsbaum. \nUnterschied: #{diff}\n\n\n" 
  end
  
  
  def test_root
    assert_equal 0,       @root <=> @root  
    assert_equal 0,       @root <=> :root 
    assert                @root >= @root 
    assert                @root <= @root 
    assert                @root >= @root   
    assert                @root <= @root       
    @tokencodes.each do |c|
      cf = c.to_fsymbol
      assert_equal( -1,    (@root <=> c.to_fsymbol     )) 
      assert_equal(  1,    (cf     <=> @root  ))
      assert_equal( -1,    (@root <=> cf                 ))       
    end
  end
  
  
  def test_specific
    assert :item.to_fsymbol <= :name.to_fsymbol
    assert :name.to_fsymbol >= :item.to_fsymbol
    assert :item.to_fsymbol   <= :abbrev.to_fsymbol
    assert :abbrev.to_fsymbol >= :item.to_fsymbol
    assert :minus.to_fsymbol >= :singlechar.to_fsymbol    
    assert :singlechar.to_fsymbol <= :minus.to_fsymbol    
  end
  
  

  

  
  

 
    
  



  
end





