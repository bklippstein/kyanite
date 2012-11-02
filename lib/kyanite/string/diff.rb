# ruby encoding: utf-8

if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end



class String       

# @!group Overlap / Diff
     
        
  # Returns the mutual part of two strings. Example:
  #  "Hello world".overlap("Hello darling") 
  #  => "Hello"
  #    
  # See more examples and tests {TestKyaniteStringDiff#test_overlap here}.    
  # @return [String] mutual part
  def overlap(b)
      return ''         if b.nil?
      b = b.to_str
      return self     if self == b
      return ''         if self[0] != b[0]

      n = [self.size, b.size].min
      (0..n).each { |i|  return self[0..i-1] unless self[i] == b[i] }
  end    

  
  # Returns the differencing part of two strings. Example:
  #  "Hello darling".diff("Hello") 
  #  => " darling"
  #      
  # When in doubt, the longest differencing string.
  # If there is still doubt, then +self+.
  #     
  # See more examples and tests {TestKyaniteStringDiff#test_diff here}.  
  # @return [String] differencing part  
  def diff(b)
      return self     if b.nil?
      b = b.to_str
      return ''        if self == b        # kein Unterschied
  
    a = self 
    a,b = b,a     if a.size >= b.size        # a ist jetzt k?rzer oder gleichlang wie b
    overlap = a.overlap(b)
    return self if overlap == ''
    return b.split(overlap)[1]
  end    

  
  

  # overlapdiff braucht genauso viel Zeit wie diff alleine. 
  
  # Returns {#diff diff} and {#overlap overlap} in one array.
  # Takes as much time as +diff+ alone.
  #
  # Symmetry: If we add +overlap+ + +diff+, we always get the longest of the two original strings.
  # If both had the same length, we get +self+.
  #
  # See examples and tests {TestKyaniteStringDiff#test_overlapdiff here}.  
  # @return [Array] mutual part, differencing part
  def overlapdiff(b)
      return '', self     if b.nil?
      b = b.to_str
      return self,''        if self == b        # kein Unterschied
  
    a = self 
    a,b = b,a     if a.size >= b.size        # a ist jetzt k?rzer oder gleichlang wie b
    overlap = a.overlap(b)
    return overlap, self if overlap == ''
    return overlap, b.split(overlap)[1]
  end        



end



class NilClass

  # see {String#overlap}
  # @return [String] Empty String  
  def overlap(*a);              '';             end  
  

  # see {String#diff}  
  # @return [String] Parameter b
  def diff(b);                  b;              end  
  

  # see {String#overlapdiff}  
  # @return [Array] ['', b] 
  def overlapdiff(b);           ['', b];        end  
end


# -----------------------------------------------------------------------------------------
# Ausprobieren
#
if $0 == __FILE__ then

puts "Hello darling".diff("Hello") 






end



