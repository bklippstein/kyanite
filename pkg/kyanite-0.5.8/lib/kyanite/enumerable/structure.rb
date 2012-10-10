# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'kyanite/general/object'
require 'kyanite/array/array'
require 'kyanite/dictionary' 




class Object

  # Enthält ein Objekt mehrere Objekte?
  # String und Range gelten nicht als Collection.
  # See TestKyaniteEnumerableStructure for tests and examples.
  def is_collection?;                 false;          end
  
end


module Enumerable

  # Enthält ein Objekt mehrere Objekte?
  # Rückgabe: true  
  # String und Range gelten nicht als Collection.
  # See TestKyaniteEnumerableStructure for tests and examples.
  def is_collection?;                 true;          end
  
end


class String 

  # ---------------------------------------------------------------------------------------------------------------------------------
  # :section: Structure
  #  

  # Enthält ein Objekt mehrere Objekte?
  # Rückgabe: false  
  # String und Range gelten nicht als Collection.
  # See TestKyaniteEnumerableStructure for tests and examples.
  def is_collection?;                 false;          end
  
  
end


class Range 

  # Enthält ein Objekt mehrere Objekte?
  # Rückgabe: false  
  # String und Range gelten nicht als Collection.
  # See TestKyaniteEnumerableStructure for tests and examples.
  def is_collection?;                 false;          end
  
end







# [ | Kyanite | Object | Array | Set | *Enumerable* | Hash | ]     | *Enumerable* | EnumerableNumerics | EnumerableStrings | EnumerableEnumerables | 
# ---
#
#
# == *General* *Enumerations*
# See TestKyaniteEnumerableStructure for tests and examples.
#
# 
module Enumerable

  # Liefert die Verteilung der size 
  # oder die Verteilung der class 
  # oder die Verteilung eines anderen Merkmals der aufgezählten Elemente.
  # die Methode gibt es auch als Hash#distribution.  
  # See TestKyaniteEnumerableStructure  for tests and examples.
  #
  def distribution( mode = :size)
    verteilung = Hash.new
    each do | element |
      value = element.respond(mode)
      if verteilung.has_key?(value)
        verteilung[value] += 1
      else
        verteilung[value] = 1
      end # if      
    end #each
    verteilung.to_a.sort   
  end
  
  
  
  

  
  # Was für Objekte beinhaltet die Collection?
  # Liefert die Klasse der Contentelemente, oder <tt>Object</tt> wenn es verschiedene sind. 
  #  
  # Parameter ist die Genauigkeit, mit der der Inhalt geprüft wird.
  #  :precision  => 1      nur das erste Element wird geprüft
  #  :precision  => 2      das erste und das letzte Element werden geprüft   (STANDARD)
  #  :precision  => :all   alle Elemente werden geprüft
  #  :ignore_nil => true   NilClass wird nicht aufgeführt                    (STANDARD)
  #  :ignore_nil => false  NilClass wird mit aufgeführt  
  #
  # See TestKyaniteEnumerableStructure  for tests and examples.
  #
  def contentclass( options={} )
    precision  = options[:precision]    || 2
    ignore_nil = options[:ignore_nil];  ignore_nil = true   if ignore_nil.nil?
    return nil   if  self.empty? 
    case precision
    
    when 1
      result = self.first.class
      if ( result == NilClass  &&  ignore_nil )
        return self.compact.contentclass( :precision => precision, :ignore_nil => false  )
      else
        return result
      end
      
    when 2
      f = self.first.class    
      l = self.last.class   
      if ( (f == NilClass || l == NilClass) &&  ignore_nil )
        return self.compact.contentclass( :precision => precision, :ignore_nil => false  )
      end      
      if f == l      
        return f
      else
        result = f.ancestors & l.ancestors
        #see result - [Object, Kernel, Precision, Perception::NumericI,  PP::ObjectMixin,  KKernel]
        return Numeric      if result.include?(Numeric)
        return Enumerable   if result.include?(Enumerable)
        return Object
      end
      
    when :all
      unless ( self.kind_of?(Hash) || self.kind_of?(Hashery::Dictionary) )
        c = self.collect {|e| e.class}
      else
        c = self.collect {| key, value | value.class}      
      end 
      c = c - [NilClass]  if ignore_nil
      c.uniq!  
      if c.empty? 
        return nil       if ignore_nil
        return NilClass   
      end
      return c[0]       if c.size == 1 
      result = c[0].ancestors
      c[1..-1].each do |e|
        result = result & e.ancestors
      end
      #see result - [Object, Kernel, Precision, Perception::NumericI,  PP::ObjectMixin,  KKernel]      
      return Numeric      if result.include?(Numeric)
      return Enumerable   if result.include?(Enumerable)
      return Object

    else # case precision
      raise ArgumentError, ':precision should be 1, 2 or :all'
    end #case
    
  end #def

end #module






# ==================================================================================
# Ausprobieren
#
if $0 == __FILE__ 

  class Array
    include Enumerable
  end  


  test = [ 1,2,3]
  puts "Hallo"
  puts  test.contentclass(:precision => :all)

  

end


