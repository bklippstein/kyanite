# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end





# @!macro enum_of_numerics
module EnumerableNumerics

  
# ======================================================================================
# @!group Mean Values
#  

  # Arithmetic mean
  #
  # Tests and examples {TestKyaniteEnumerableNumerics here}.
  # @return [Float]   
  def mean
    self.inject(0.0) { |sum, i | sum += i } / self.length.to_f 
  end
  alias avg              mean
  alias average          mean
  alias mean_arithmetric mean
 

  # Harmonic mean
  #
  # Usually, the harmonic mean is defined only for positive numbers.
  # The option <tt>:allow_negative => true </tt> can also include negative numbers in the calculation.
  # Then the result will be a weighted arithmetic mean of the harmonic mean of all positive elements
  # and the harmonic mean of all negative elements.
  # @return [Float]  
  def mean_harmonic( options={} )
    return 0              if self.empty?  
    return self.first     if self.size == 1
    allow_negative = options[:allow_negative] || false
    unless allow_negative
      summe = 0
      self.each { |x| summe += ( 1.0/x ) }
      return self.size / summe
      
    else
      positives = ArrayOfNumerics.new
      negatives = ArrayOfNumerics.new
      self.each do |e|
        if e >= 0
          positives << e
        else
          negatives << -e
        end
      end #each
      if positives.size > 0 
        if negatives.size > 0
          return  ( positives.mean_harmonic(:allow_negative => false) * positives.size -
                    negatives.mean_harmonic(:allow_negative => false) * negatives.size
                  ) / (positives.size + negatives.size).to_f
        else
          return  positives.mean_harmonic(:allow_negative => false)
        end
      else
        return   -negatives.mean_harmonic(:allow_negative => false)
      end

    end #if allow_negative
  end #def 
  
 

  # Geometric mean
  # @return [Float]    
  def mean_geometric
    self.prd ** ( 1.0/self.size ) 
  end  
  

  
# ======================================================================================
# @!group Sum, Product, Parallel
#    
  
  
  # Sum
  #
  # Tests and examples {TestKyaniteEnumerableNumerics here}.
  # @return [Numeric]    
  def summation
    # Methode darf nicht sum heißen, kollidiert sonst schnell mit ActiveRecord.  
    self.inject(0.0) { |sum, i | sum += i }  
  end  
  
  
  # Product
  #
  # Tests and examples {TestKyaniteEnumerableNumerics here}.
  # @return [Numeric]    
  def prd
    # Methode darf nicht product heißen, die gibt es nämlich schon.  
    self.inject(1.0) { |p, i | p *= i }  
  end    
  
  # Parallel
  #
  # Result is equal to the total resistance of resistors in parallel circuits.
  # Tests and examples {TestKyaniteEnumerableNumerics here}.
  # @return [Float]    
  def parallel
    mean_harmonic / size  
  end
    


end #class






# @!macro enum_of_numerics
class ArrayOfNumerics < Array 
  include EnumerableNumerics
end



class Array

  # @!group Cast
  # Returns {ArrayOfNumerics} (this is an {Array} with modul {EnumerableNumerics} included)
  # @return [ArrayOfNumerics]  
  def to_array_of_numerics
    ArrayOfNumerics.new(self)
  end
  #@!endgroup
  
end


if defined? TransparentNil
  class NilClass
    def average;                                  nil;            end  
    def avg;                                      nil;            end  
    def mean;                                     nil;            end  
    def mean_arithmetric;                         nil;            end  
    def mean_geometric;                           nil;            end  
    def mean_harmonic(*a);                        nil;            end  
    def parallel(*a);                             nil;            end           
    def prd;                                      nil;            end  
    def sum;                                      nil;            end  
    def summation;                                nil;            end  
  end
end

# ==================================================================================
# Ausprobieren
#
if $0 == __FILE__ 









end






