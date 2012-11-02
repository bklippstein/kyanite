# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'
require 'kyanite/enumerable/enumerable_numerics'




# @!macro enum_of_numerics
class TestKyaniteEnumerableNumerics < UnitTest

  
  def test_01_sum
    assert_equal 2,                   [2].to_array_of_numerics.summation
    assert_equal 4,                   [2,2].to_array_of_numerics.summation
    assert_equal 6,                   [2,2,2].to_array_of_numerics.summation
    assert_equal 8,                   [2,2,2,2].to_array_of_numerics.summation 
    assert_equal 8.5,                 [2,2,2,2,0.5].to_array_of_numerics.summation 
  end
  
  
  
  def test_01_prd
    assert_equal 2,                   [2].to_array_of_numerics.prd
    assert_equal 6,                   [2,3].to_array_of_numerics.prd
    assert_equal -12,                 [2,2,-3].to_array_of_numerics.prd
    assert_equal 1,                   [0.5,0.5,2,2].to_array_of_numerics.prd 
    assert_equal 5000,                [50, 100].to_array_of_numerics.prd 
  end  
  
  
  def test_avg
    a = [1,2,3,4,5,6,7,8,9].to_array_of_numerics
    assert_equal 5.0, a.average  
  
    assert_equal 2,                   ([2].to_array_of_numerics.avg * 100000000).round / 100000000.0
    assert_equal 2.5,                 ([2,3].to_array_of_numerics.avg * 100000000).round / 100000000.0
    assert_equal 2.5,                 ([3,2].to_array_of_numerics.avg * 100000000).round / 100000000.0
    assert_equal 0.33333333,          ([2,2,-3].to_array_of_numerics.avg * 100000000).round / 100000000.0
    assert_equal 1.25,                ([0.5,0.5,2,2].to_array_of_numerics.avg * 100000000).round / 100000000.0
    
    assert_equal 75,                  ([ 50, 100 ].to_array_of_numerics.mean_arithmetric * 100000000).round / 100000000.0
    assert_equal 66.66666667,         ([ 50, 100 ].to_array_of_numerics.mean_harmonic * 100000000).round / 100000000.0
    assert_equal 70.71067812,         ([ 50, 100 ].to_array_of_numerics.mean_geometric * 100000000).round / 100000000.0
    
    assert_equal 66.66666667,         ([ 100, 0,         100 ].to_array_of_numerics.mean_arithmetric * 100000000).round / 100000000.0
    assert_equal 66.6666667,          ([ 100, 0.0000001, 100 ].to_array_of_numerics.mean_arithmetric * 100000000).round / 100000000.0
    assert_equal 0.0,                 ([ 100, 0,         100 ].to_array_of_numerics.mean_harmonic * 100000000).round / 100000000.0
    assert_equal 3.0e-007,            ([ 100, 0.0000001, 100 ].to_array_of_numerics.mean_harmonic * 100000000).round / 100000000.0
    assert_equal 0,                   ([ 100, 0,         100 ].to_array_of_numerics.mean_geometric * 100000000).round / 100000000.0
    assert_equal 0.1,                 ([ 100, 0.0000001, 100 ].to_array_of_numerics.mean_geometric * 100000000).round / 100000000.0    
  end   
  
  
  def test_mean_harmonic
    assert_equal 66.66666667,         ([ 50, 100 ].to_array_of_numerics.mean_harmonic * 100000000).round / 100000000.0  
    assert_equal 0.0,                 ([ 100, 0,         100 ].to_array_of_numerics.mean_harmonic * 100000000).round / 100000000.0
    assert_equal 3.0e-007,            ([ 100, 0.0000001, 100 ].to_array_of_numerics.mean_harmonic * 100000000).round / 100000000.0    
    assert_equal 4,                   ([ 1, -2 ].to_array_of_numerics.mean_harmonic * 100000000).round / 100000000.0    # formal richtig, aber sinnlos
    assert_equal -0.5,                ([ 1, -2 ].to_array_of_numerics.mean_harmonic(:allow_negative => true) * 100000000).round / 100000000.0    
    assert_equal -0.5,                ([ 1, 1, -2, -2 ].to_array_of_numerics.mean_harmonic(:allow_negative => true) * 100000000).round / 100000000.0    
    assert_equal -2,                  ([ -2, -2 ].to_array_of_numerics.mean_harmonic(:allow_negative => true) * 100000000).round / 100000000.0    
    assert_equal 2,                   ([ 2, 2 ].to_array_of_numerics.mean_harmonic(:allow_negative => true) * 100000000).round / 100000000.0    
    assert_equal 0,                   ([ -2, 2 ].to_array_of_numerics.mean_harmonic(:allow_negative => true) * 100000000).round / 100000000.0    
    assert_equal 0,                   ([ 2, -2 ].to_array_of_numerics.mean_harmonic(:allow_negative => true) * 100000000).round / 100000000.0    
    assert_equal 0.66666667,          ([ 2, 2, -2 ].to_array_of_numerics.mean_harmonic(:allow_negative => true) * 100000000).round / 100000000.0    
  end
  
  
  def test_parallel
    assert_equal 1,                   ([1].to_array_of_numerics.parallel * 100000000).round / 100000000.0
    assert_equal 0.5,                 ([1,1].to_array_of_numerics.parallel * 100000000).round / 100000000.0
    assert_equal 0.33333333,          ([1,1,1].to_array_of_numerics.parallel * 100000000).round / 100000000.0   
    assert_equal 0.25,                ([1,1,1,1].to_array_of_numerics.parallel * 100000000).round / 100000000.0
    
    assert_equal 2,                   ([2].to_array_of_numerics.parallel * 100000000).round / 100000000.0
    assert_equal 1,                   ([2,2].to_array_of_numerics.parallel * 100000000).round / 100000000.0
    assert_equal 0.66666667,          ([2,2,2].to_array_of_numerics.parallel * 100000000).round / 100000000.0   
    assert_equal 0.5,                 ([2,2,2,2].to_array_of_numerics.parallel * 100000000).round / 100000000.0    
    assert_equal 0.5,                 ([2,2,1].to_array_of_numerics.parallel * 100000000).round / 100000000.0      
  end    

  


  
  

end # class 
