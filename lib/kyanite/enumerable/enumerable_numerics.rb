# ruby encoding: utf-8

# [ | Kyanite | Object | Array | Set | *Enumerable* | Hash | ]     | Enumerable | *EnumerableNumerics* | EnumerableStrings | EnumerableEnumerables | 
# ---
#
#
# == *Enumeration* *Of* *Numerics*
# See TestKyaniteEnumerableNumerics for tests and examples.
# See ArrayOfNumerics for an Array with modul EnumerableNumerics included. 
#
#
module EnumerableNumerics

  
# ======================================================================================
# :section: Mittelwerte
#  

  # Arithmetrischer Mittelwert
  # Tests and examples see TestKyaniteEnumerableNumerics.
  #    
  def mean
    self.inject(0.0) { |sum, i | sum += i } / self.length.to_f 
  end
  alias avg              mean
  alias average          mean
  alias mean_arithmetric mean
 
  # Harmonischer Mittelwert
  #
  # Normalerweise ist der harmonische Mittelwert nur für positive Zahlen sinnvoll definiert.
  # Mit der Option <tt>:allow_negative => true </tt>kann man aber auch negative Zahlen mit einbeziehen.
  # Dann wird der harmonische Mittelwert aller positiven Elemente mit dem 
  # harmonische Mittelwert aller negativen Elemente verrechnet (als gewichtetes arithmetisches Mittel).
  #
  # Tests and examples see TestKyaniteEnumerableNumerics.
  #    
  def mean_harmonic( options={} )
    return 0              if self.empty?  
    return self.first     if self.size == 1
    allow_negative = options[:allow_negative] || false
    unless allow_negative
      summe = 0
      self.each { |x| summe += ( 1.0/x ) }
      return self.size / summe
      
    else
      positives = []
      negatives = []
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
  
 
  # Geometrischer Mittelwert 
  def mean_geometric
    self.prd ** ( 1.0/self.size ) 
  end  
  

  
# ======================================================================================
# :section: Summe, Produkt, Parallelschaltung
#    
  
  
  # Summe
  #
  # Methode darf nicht sum heißen, kollidiert sonst schnell mit ActiveRecord.
  # Tests and examples see TestKyaniteEnumerableNumerics.
  #  
  def summation
    self.inject(0.0) { |sum, i | sum += i }  
  end  
  
  
  # Produkt
  # Methode darf nicht product heißen, die gibt es nämlich schon.
  # Tests and examples see TestKyaniteEnumerableNumerics.
  #    
  def prd
    self.inject(1.0) { |p, i | p *= i }  
  end    
  
  
  # Ergebnis entspricht der Parallelschaltung von Widerständen.
  # Tests and examples see TestKyaniteEnumerableNumerics.
  #    
  def parallel
    mean_harmonic / size  
  end
    


end #class



# [ | Kyanite | Object | *Array* | Set | Enumerable | Hash | ]     | Array |  *ArrayOfNumerics*  | ArrayOfStrings |  ArrayOfEnumerables | Range | 
# ---
#
#
# == *Array* *Of* *Numerics*
# An ArrayOfNumerics is an Array with modul EnumerableNumerics included. 
# See TestKyaniteEnumerableNumerics for tests and examples.
#
class ArrayOfNumerics < Array 
  include EnumerableNumerics
end



class Array

  # Liefert ein ArrayOfNumerics (das ist ein Array mit inkludiertem Modul EnumerableNumerics)
  def to_array_of_numerics
    ArrayOfNumerics.new(self)
  end
  
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
  class Array
    include EnumerableNumerics
  end  








end






