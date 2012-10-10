# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'kyanite/unit_test'
require 'kyanite/string/nested' 


# Tests for String
#
class TestKyaniteStringNested < UnitTest
  
  def test_010_anti
    test = '()[]<>{}'
    test.split(//).each do |t|
      assert_equal t, t.anti.anti
      assert t != t.anti
    end
    assert_equal '</hallo>', '<hallo>'.anti
    assert_equal '<hallo>', '</hallo>'.anti
    assert_equal '*', '*'.anti
    assert_equal '"', '"'.anti
    assert_equal "'", "'".anti
  end
  
  
  def test_020_index_bracket
    test = 'Hallo welt wort'
    assert_equal nil,       test.index_bracket(/['"({<\[]/)
     
    test = 'Hallo(welt)wort'
    assert_equal 5..10,     test.index_bracket(/['"({<\[]/)
    assert_equal 5..10,     test.index_bracket('(')
    assert_equal nil,       test.index_bracket(')')
    assert_equal nil,       test.index_bracket('(',6)
    
    test = 'Hallo"welt"wort'
    assert_equal 5..10,     test.index_bracket(/['"({<\[]/)
    assert_equal 5..10,     test.index_bracket('"')
    assert_equal nil,       test.index_bracket(')')
    assert_equal nil,       test.index_bracket('(',6)    
    
    test = 'Hallo[welt]wort'
    assert_equal 5..10,    test.index_bracket(/['"({<\[]/)
    
    test = '(hallo) [welt] wort'    
    assert_equal 0..6,      test.index_bracket(/['"({<\[]/)
    assert_equal 8..13,     test.index_bracket(/['"({<\[]/, 1 )
    
    test = 'Hallo(welt(klammer)bla(blubb)nuff)wort'
    # see RULER
    # see test
    # see test[test.index_bracket('(',11)]
    assert_equal 5..33,     test.index_bracket(/['"({<\[]/)
    assert_equal 10..18,    test.index_bracket('(',6)    
    assert_equal 22..28,    test.index_bracket('(',11)     
  end
  
  
  
  
 

  
  
  def test_030_mask_ungeklammert
    assert_raise(ArgumentError) {result = test.mask(1,0)   {|s| s.upcase} }     
    assert_raise(ArgumentError) {result = test.mask(nil,1) {|s| s.upcase} }     
    assert_raise(ArgumentError) {result = test.mask(1,nil) {|s| s.upcase} } 
    
    test = 'hallo'
    
    result = test.mask {|s| s.upcase}  
    assert_equal 'hallo', result
    result = test.mask {|s| '-'}  
    assert_equal 'hallo', result    
    result = test.mask {|s| "+#{s}+"}  
    assert_equal 'hallo', result     

    result = test.mask(:level_start => 0) {|s| s.upcase}  
    assert_equal 'HALLO', result
    result = test.mask(:level_start => 0) {|s| '-'}  
    assert_equal '-', result    
    result = test.mask(:level_start => 0) {|s| "+#{s}+"}  
    assert_equal '+hallo+', result   
    
    result = test.mask(:level_start => 0, :level_end => 0) {|s| s.upcase}  
    assert_equal 'HALLO', result
    result = test.mask(:level_start => 0, :level_end => 0) {|s| '-'}  
    assert_equal '-', result    
    result = test.mask(:level_start => 0, :level_end => 0) {|s| "+#{s}+"}  
    assert_equal '+hallo+', result        
  end      
  
  
  def test_040_mask_eine_klammer 
    test = 'a_level_0(level1)b_level_0'  
    options = {  :pattern      => /\(/   }
    
    result = test.mask(options) {|s| s.upcase}   
    assert_equal 'a_level_0(LEVEL1)b_level_0',          result     
    result = test.mask(options) {|s| '-'}  
    assert_equal 'a_level_0(-)b_level_0',               result  
    result = test.mask(options) {|s| " +#{s}+ "}  
    assert_equal 'a_level_0( +level1+ )b_level_0',      result    
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0,
                        :pattern      => /\(/                        
                      ) {|s| s.upcase}   
    assert_equal 'A_LEVEL_0(level1)B_LEVEL_0',          result   
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0,
                        :pattern      => /\(/    
                       ) {|s| '-'}   
    assert_equal '-(level1)-', result  
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0,
                        :pattern      => /\(/    
                      ) {|s| " +#{s}+ "}       
    assert_equal ' +a_level_0+ (level1) +b_level_0+ ',  result        
  end
  
  
  def test_050_mask_zwei_klammern 
    test = 'r_level_0<a_level_1>s_level_0<b_level_1>t_level_0'  
    
    result = test.mask {|s| s.upcase}   
    assert_equal 'r_level_0<A_LEVEL_1>s_level_0<B_LEVEL_1>t_level_0',             result     
    result = test.mask {|s| '-'}  
    assert_equal 'r_level_0<->s_level_0<->t_level_0',                             result   
    result = test.mask {|s| " +#{s}+ "}  
    assert_equal 'r_level_0< +a_level_1+ >s_level_0< +b_level_1+ >t_level_0',     result     
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0 ) {|s| s.upcase}   
    assert_equal 'R_LEVEL_0<a_level_1>S_LEVEL_0<b_level_1>T_LEVEL_0',             result 
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0 ) {|s| '-'}  
    assert_equal '-<a_level_1>-<b_level_1>-',                                     result  
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0 ) {|s| " +#{s}+ "} 
    assert_equal ' +r_level_0+ <a_level_1> +s_level_0+ <b_level_1> +t_level_0+ ', result        
  end  
  
  
  def test_060_mask_leer 
    test = ''  
    
    result = test.mask {|s| s.upcase}  
    assert_equal '', result
    result = test.mask {|s| nil }  
    assert_equal '', result    
    result = test.mask {|s| '-'}  
    assert_equal '', result       
    result = test.mask {|s| s + '+'}  
    assert_equal '', result    
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0 ) {|s| s.upcase}   
    assert_equal '', result
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0 ) {|s| nil}   
    assert_equal '', result    
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0 ) {|s| '-'}  
    assert_equal '-', result     
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0,
                        :skip_empty   => true) {|s| '-'}  
    assert_equal '', result        
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0 ) {|s| s + '+'}  
    assert_equal '+', result   

    result = test.mask( :level_start  => 0,
                        :level_end    => 0,
                        :skip_empty   => true) {|s| s + '+'}   
    assert_equal '', result        
  end
  
  
  def test_070_mask_start_mit_level_1
    options = {  :pattern      => /\(/   }  
    test = '(level1)level0'  
    
    result = test.mask(options) {|s| s.upcase}   
    assert_equal '(LEVEL1)level0',            result     
    result = test.mask(options) {|s| '-'}  
    assert_equal '(-)level0',                 result  
    result = test.mask(options) {|s| "+#{s}+"}  
    assert_equal '(+level1+)level0',          result    
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0,
                        :pattern      => /\(/    
                      ) {|s| s.upcase}   
    assert_equal '(level1)LEVEL0',            result 
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0,
                        :pattern      => /\(/    
                      ) {|s| '-'} 
    assert_equal '-(level1)-',                result  
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0,
                        :pattern      => /\(/,                            
                        :skip_empty   => true) {|s| '-'}  
    assert_equal '(level1)-', result        
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0,
                        :pattern      => /\(/
                      ) {|s| "+#{s}+"} 
    assert_equal '++(level1)+level0+',          result  

    result = test.mask( :level_start  => 0,
                        :level_end    => 0,
                        :pattern      => /\(/,                           
                        :skip_empty   => true) {|s| "+#{s}+"}   
    assert_equal '(level1)+level0+', result      
  end  
  
  
  def test_080_mask_end_mit_level_1
    test = 'level0(level1)'  
    options = {  :pattern      => /\(/   }      
    
    result = test.mask(options) {|s| s.upcase}   
    assert_equal 'level0(LEVEL1)',            result     
    result = test.mask(options) {|s| '-'}  
    assert_equal 'level0(-)',                 result  
    result = test.mask(options) {|s| "+#{s}+"}  
    assert_equal 'level0(+level1+)',          result    
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0,                        
                        :pattern      => /\(/  
                      ) {|s| s.upcase}  
    assert_equal 'LEVEL0(level1)',            result    
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0,                       
                        :pattern      => /\(/
                      ) {|s| '-'} 
    assert_equal '-(level1)-',                result  
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0,
                        :pattern      => /\(/,                         
                        :skip_empty   => true) {|s| '-'}  
    assert_equal '-(level1)', result       
    
    result = test.mask( :level_start  => 0,
                        :level_end    => 0,
                        :pattern      => /\(/
                      ) {|s| "+#{s}+"} 
    assert_equal '+level0+(level1)++',          result     

    result = test.mask( :level_start  => 0,
                        :level_end    => 0,
                        :pattern      => /\(/,                         
                        :skip_empty   => true) {|s| "+#{s}+"}  
    assert_equal '+level0+(level1)', result 
  end    
  
  
  
  def test_090_mask_multilevel
    test    = '((((()))))'
    options = {  :pattern      => /\(/   } 
    
    result = test.mask(options) {|s| "+#{s}+"}  
    assert_equal '(++(++(++(++(++)++)++)++)++)',          result    
    
    result = test.mask( :level_start  => 0,
                        :skip_empty   => false,
                        :pattern      => /\(/  
                      ) {|s| "+#{s}+"}    
    assert_equal '++(++(++(++(++(++)++)++)++)++)++',          result     

    result = test.mask( :level_start  => 0,
                        :pattern      => /\(/,      
                        :skip_empty   => true) {|s| "+#{s}+"}    
    assert_equal test,          result    

    result = test.mask( :level_start  => 2,
                        :level_end    => 4,
                        :pattern      => /\(/  
                      ) {|s| "+#{s}+"}    
    assert_equal '((++(++(++()++)++)++))',          result     
  end  
  
  
  def test_100_mask_with_brackets
    test = 'level0(lev(el)1)level0'  
    options = {:with_brackets => true}
    
    result = test.mask( :with_brackets  => true,
                        :level_start    => 0,
                        :level_end      => 0,
                        :pattern        => /\(/  
                        ) {|s| s.tr('()','{}')}   
    assert_equal 'level0{lev(el)1}level0'  ,          result     
    
    result = test.mask( :with_brackets  => true,
                        :level_start    => 1,
                        :level_end      => 1,
                        :pattern        => /\(/  
                        ) {|s| s.tr('()','<>')}   
    assert_equal 'level0(lev<el>1)level0'  ,          result       
    
     
  end  
  
  

 
  
  
end # class

































