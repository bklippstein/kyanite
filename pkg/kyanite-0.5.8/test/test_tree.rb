# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'kyanite/unit_test'                                                  
require 'kyanite/tree'
require 'kyanite/symbol'




# Tests for Tree::TreeNode
class TestKyaniteTree < UnitTest

  def setup
  
    #      * root
    #      |---+ item ---> de ---> name
    #      |                |
    #      |                +---> abbrev
    #      |    
    #      |
    #      |---+ singlechar
    #      |    |---- struktur ---> punkt ---> satzende
    #      |    |---> minus
    #      |    +---> sonderzeichen
    #      |
    #      |---> num
    #      |---- site ---> url
    #      +---> sonstiges    

    
    # Oberste Ebene
    ttroot =  Tree::TreeNode.new(:root)
    ttroot << Tree::TreeNode.new(:ta_item)       
    ttroot << Tree::TreeNode.new(:ta_num) 
    ttroot << Tree::TreeNode.new(:ta_site) << Tree::TreeNode.new(:ta_url) 
    ttroot << Tree::TreeNode.new(:ta_sonstiges)  

    # :singlechar
    ttroot << Tree::TreeNode.new(:singlechar)        
                          ttroot[:singlechar] << Tree::TreeNode.new(:ta_struktur) << Tree::TreeNode.new(:ta_punkt) << Tree::TreeNode.new(:wa_satzende) 
                          ttroot[:singlechar] << Tree::TreeNode.new(:ta_minus) 
                          ttroot[:singlechar] << Tree::TreeNode.new(:ta_sonderzeichen)  

    # :item    
    ttroot[:ta_item] << (wa_word=Tree::TreeNode.new(:wa_word)) << Tree::TreeNode.new(:wa_name)    
                        wa_word << Tree::TreeNode.new(:wa_abbrev)   
                        wa_word << Tree::TreeNode.new(:wa_multi)   
                                     

    ttroot_hash = {}
    ttroot_hash[:de] = ttroot

    @tokenizer_tree_root = ttroot_hash    
    
 
  end
  
  


  def pest_allkeys
  
    assert_equal [   :singlechar,
                     :ta_item,
                     :ta_minus,
                     :ta_num,
                     :ta_punkt,
                     :ta_site,
                     :ta_sonderzeichen,
                     :ta_sonstiges,
                     :ta_struktur,
                     :ta_url,
                     :wa_abbrev,
                     :wa_multi,
                     :wa_name,
                     :wa_satzende, 
                     :wa_word      ], @tokenizer_tree_root[:de].find(:root).all_child_keys.sort
        
    assert_equal [:wa_abbrev, :wa_multi, :wa_name, :wa_word],
        @tokenizer_tree_root[:de].find(:ta_item).all_child_keys.sort        
  end
  
  
  def pest_see_tree
    puts
    puts
    @tokenizer_tree_root[:de].print_tree 
  end  
  

end # class 




