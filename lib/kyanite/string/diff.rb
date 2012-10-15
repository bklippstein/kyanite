# ruby encoding: utf-8 


class String

        
# ---------------------------------------------------------------------------------------------------------------------------------
# :section: Overlap / Diff
# See TestKyaniteStringDiff for tests and examples.         
        
  # Gibt den gemeinsamen Teil zweier Strings aus (von vorne gezählt).  
  #    
  # Beispiele & Tests siehe TestKyaniteStringDiff#test_overlap    
  def overlap(b)
      return ''         if b.nil?
      b = b.to_str
      return self     if self == b
      return ''         if self[0] != b[0]

      n = [self.size, b.size].min
      (0..n).each { |i|  return self[0..i-1] unless self[i] == b[i] }
  end    

  
  # Liefert den Unterschied zwischen zwei Strings zurück.
  # Im Zweifelsfall immer den längsten String.
  # Wenn dann immer noch Zweifel, dann self. 
  #    
  # Beispiele & Tests siehe TestKyaniteStringDiff#test_diff    
  def diff(b)
      return self     if b.nil?
      b = b.to_str
      return ''        if self == b        # kein Unterschied
  
    a = self 
    a,b = b,a     if a.size >= b.size        # a ist jetzt k�rzer oder gleichlang wie b
    overlap = a.overlap(b)
    return self if overlap == ''
    return b.split(overlap)[1]
  end    

  
  
  # Liefert zugleich overlap und diff zurück.
  # Symmetrie: Rechnet man overlap + diff, so erhält man immer den längsten der beiden ursprünglichen Strings.
  # Waren beide gleichlang, so erhält man self.
  # overlapdiff braucht genauso viel Zeit wie diff alleine. 
  #
  # Beispiele & Tests siehe TestKyaniteStringDiff#test_overlapdiff    
  def overlapdiff(b)
      return '', self     if b.nil?
      b = b.to_str
      return self,''        if self == b        # kein Unterschied
  
    a = self 
    a,b = b,a     if a.size >= b.size        # a ist jetzt k�rzer oder gleichlang wie b
    overlap = a.overlap(b)
    return overlap, self if overlap == ''
    return overlap, b.split(overlap)[1]
  end        



end


if defined? TransparentNil
  class NilClass

    # Rückgabe: Leerer String,
    # siehe String#overlap
    def overlap(*a);              '';             end  
    
    # Rückgabe: b,
    # siehe String#diff  
    def diff(b);                  b;              end  
    
    # Rückgabe: ['', b],
    # siehe String#overlapdiff
    def overlapdiff(b);           ['', b];        end  
  end
end





