# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'kyanite/unit_test'     
require 'kyanite/optimizer' 


# Tests for Optimizer
class TestKyaniteOptimizer <  UnitTest

  
  def test_basics
    test = Optimizer.new
    test.push  1,  'hallo'
    test.push  5,  'eintrag'
    test.push  6,  'maximum'
    test.push -1,  'minimum'
    test.push -1,  'noch ein minimum'  
    test.push  6,  'noch ein maximum'    
    test.push  0,   'blubb'
    assert_equal 'minimum',                     test.content_min
    assert_equal  -1,                           test.score_min
    assert_equal 'maximum',                     test.content_max
    assert_equal  6,                            test.score_max   
    
    assert_equal true,                          test.delete_min
    assert_equal 'blubb',                       test.content_min
    assert_equal  0,                            test.score_min 
    assert_equal 'maximum',                     test.content_max
    assert_equal  6,                            test.score_max   
    
    assert_equal true,                          test.delete_max
    assert_equal 'eintrag',                     test.content_max
    assert_equal  5,                            test.score_max
    assert_equal 'blubb',                       test.content_min
    assert_equal  0,                            test.score_min 
    test.push  6,  'maximum'
    assert_equal 'maximum',                     test.content_max
    assert_equal  6,                            test.score_max       
  end
  
  
  
  def test_range
    test = Optimizer.new
    test.push 1,   'hallo'
    test.push 5,   'eintrag'
    test.push 6,   'maximum'
    test.push -1,  'minimum'
    test.push -1,  'noch ein minimum'  
    test.push  6,  'noch ein maximum'    
    test.push 0,   'blubb'
    assert_equal 'minimum',                     test.content_min(0..0)
    assert_equal 'minimum',                     test.content_min(0)
    assert_equal 'noch ein minimum',            test.content_min(1..1)
    assert_equal 'noch ein minimum',            test.content_min(1)
    assert_equal ['minimum', 
                  'noch ein minimum'],          test.content_min(0..-1)
    assert_equal  -1,                           test.score_min
    assert_equal 'maximum',                     test.content_max(0..0)
    assert_equal 'maximum',                     test.content_max(0)
    assert_equal 'noch ein maximum',            test.content_max(1..1)
    assert_equal 'noch ein maximum',            test.content_max(1)
    assert_equal ['maximum', 
                  'noch ein maximum'],          test.content_max(0..1)
    # assert_equal ['noch ein maximum',                   
                  # 'maximum'],                   test.content_max(1..0)
    assert_equal  6,                            test.score_max   
  end  

  
  def test_leer
    test = Optimizer.new
    assert_equal nil,                           test.content_min
    assert_equal nil,                           test.score_min 
    assert_equal nil,                           test.content_max
    assert_equal nil,                           test.score_max   
  end   
  
  
  def pppest_cleanup
    test = Optimizer.new
    assert_equal false,                         test.cleanup!    
    assert_equal 0,                             test.size  
    test.push  1,  'hallo'
    assert_equal false,                         test.cleanup!
    assert_equal 1,                             test.size      
    test.push  5,  'eintrag'
    assert_equal false,                         test.cleanup! 
    assert_equal 2,                             test.size  
    test.push  6,  'maximum'
    assert_equal true,                          test.cleanup! 
    assert_equal 2,                             test.size  
    test.push -1,  'minimum'
    assert_equal true,                          test.cleanup! 
    assert_equal 2,                             test.size      
    test.push -1,  'noch ein minimum'
    assert_equal false,                         test.cleanup!      
    assert_equal 2,                             test.size      
    test.push  0,  'blubb'
    assert_equal true,                          test.cleanup!
    assert_equal 2,                             test.size      
    test.push  6,  'noch ein maximum'
    assert_equal false,                         test.cleanup! 
    assert_equal 2,                             test.size      
    
    assert_equal 'minimum',                     test.content_min[0]
    assert_equal  -1,                           test.score_min
    assert_equal 'maximum',                     test.content_max[0]
    assert_equal  6,                            test.score_max       
  end

 
    
    
end # class

































