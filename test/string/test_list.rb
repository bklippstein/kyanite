# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'kyanite/unit_test'
require 'kyanite/dictionary'  
require 'kyanite/string/list'
require 'kyanite/string/chars'
WA_ABBREV         = :abbrev      unless defined?(WA_ABBREV)


# Tests for String
#
class TestKyaniteStringList < UnitTest
    

  def test_list_with_ohne_block
  
    array = ['Anna','Birte','Charlie']
    
    
    # normale Verwendung
    assert_equal  "kisses_from = 'Anna' OR kisses_from = 'Birte' OR kisses_from = 'Charlie'",
                  "kisses_from = ".list_with(array)
                  
    assert_equal  "kisses_from='Anna' AND kisses_from='Birte' AND kisses_from='Charlie'",
                  "kisses_from=".list_with(array, :sep => ' AND ')   

    assert_equal  "kisses_from='Anna' AND kisses_from='Birte'",
                  "kisses_from=".list_with(['Anna','Birte'], :sep => ' AND ')    


                  

    # assert_equal  'kisses_from ="Anna" AND kisses_from ="Birte" AND kisses_from ="Charlie"',
                  # 'kisses_from ='.list_with(array, :pre => '"', :post => '"')   

                  
    # leeres Array
    assert_equal  "FALSE",          "kisses_from = ".list_with(nil)                  
    assert_equal  "FALSE",          "kisses_from = ".list_with('')                  
    assert_equal  "FALSE",          "kisses_from = ".list_with([])                  
    assert_equal  "FALSE",          "kisses_from = ".list_with('',  :sep => 'gg')                  
    assert_equal  "FALSE",          "kisses_from = ".list_with('',  :pre => 'gg')                  
    assert_equal  "FALSE",          "kisses_from = ".list_with(nil, :post => 'gg')                                 
    assert_equal  "",               "kisses_from = ".list_with([],  :empty => '')  
    
    # Einzelelement
    assert_equal  "kisses_from = 'Anna'",   "kisses_from = ".list_with(['Anna'])   
    assert_equal  "kisses_from = 'Anna'",   "kisses_from = ".list_with('Anna')   
    assert_equal  "kisses_from = 'Anna'",   "kisses_from = ".list_with(['Anna'], :sep => ' AND ')   
    assert_equal  "kisses_from = <Anna>",   "kisses_from = ".list_with(['Anna'], :pre => '<', :post => '>')   
                  
   
   array = [:multi, WA_ABBREV]
   assert_equal   "AND worte_from.kat_multi=1 OR worte_from.kat_abbrev=1",
                  'AND ' + 'worte_from.kat_'.list_with(array, :pre => '', :post => '=1', :sep => ' OR ', :empty => 'TRUE' )

   array = [:multi]       
   assert_equal   "AND worte_from.kat_multi=1",
                  'AND ' + 'worte_from.kat_'.list_with(array, :pre => '', :post => '=1', :sep => ' OR ', :empty => 'TRUE' )   
                  
   array = []       
   assert_equal   "AND TRUE",
                  'AND ' + 'worte_from.kat_'.list_with(array, :pre => '', :post => '=1', :sep => ' OR ', :empty => 'TRUE' )                   


  end    
    
  
  
  def test_list_with_mit_block
  
    array = ['Anna','Birte','Charlie']
    
    
    # mit lesendem Block
    assert_equal  "kisses_from = 'anna' OR kisses_from = 'birte' OR kisses_from = 'charlie'",
                  "kisses_from = ".list_with(array) { |e| e.downcase2 }                        
                  
    # ohne Block: Objekte sind unverändert geblieben
    assert_equal  "kisses_from='Anna' AND kisses_from='Birte' AND kisses_from='Charlie'",
                  "kisses_from=".list_with(array, :sep => ' AND ')   

                  
    # leeres Array
    assert_equal  "FALSE",          "kisses_from = ".list_with(nil) { |e| e.downcase2 }                 
    assert_equal  "FALSE",          "kisses_from = ".list_with('') { |e| e.downcase2 }                     
    assert_equal  "FALSE",          "kisses_from = ".list_with([]) { |e| e.downcase2 }                     
    assert_equal  "FALSE",          "kisses_from = ".list_with('',  :sep => 'gg') { |e| e.downcase2 }                     
    assert_equal  "FALSE",          "kisses_from = ".list_with('',  :pre => 'gg') { |e| e.downcase2 }                     
    assert_equal  "FALSE",          "kisses_from = ".list_with(nil, :post => 'gg') { |e| e.downcase2 }                                    
    assert_equal  "",               "kisses_from = ".list_with([],  :empty => '') { |e| e.downcase2 }     
    
    # Einzelelement
    einzelelement = ['Anna']
    assert_equal  "kisses_from = 'anna'",   "kisses_from = ".list_with(einzelelement) { |e| e.downcase2 }   
    assert_equal  "kisses_from = 'Anna'",   "kisses_from = ".list_with(einzelelement)   
    assert_equal  "kisses_from = 'anna'",   "kisses_from = ".list_with(einzelelement, :sep => ' AND ') { |e| e.downcase2 }   
    assert_equal  "kisses_from = 'Anna'",   "kisses_from = ".list_with(einzelelement, :sep => ' AND ')   
    assert_equal  "kisses_from = <anna>",   "kisses_from = ".list_with(einzelelement, :pre => '<', :post => '>') { |e| e.downcase2 }        
    assert_equal  "kisses_from = <Anna>",   "kisses_from = ".list_with(einzelelement, :pre => '<', :post => '>')      
    einzelelement = 'Anna'
    assert_equal  "kisses_from = 'anna'",   "kisses_from = ".list_with(einzelelement) { |e| e.downcase2 }     
    assert_equal  "kisses_from = 'Anna'",   "kisses_from = ".list_with(einzelelement)   

  end      
  
    
    
end # class

































