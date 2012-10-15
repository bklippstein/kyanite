# ruby encoding: utf-8
require 'active_support/core_ext/hash/slice'          # Slice a hash to include only the given keys. 
require 'active_support/core_ext/hash/reverse_merge'  # Merges the caller into +other_hash+. 
require 'kyanite/enumerable'                          # is_collection?

# class Hash
  # include ActiveSupport::CoreExtensions::Hash::ReverseMerge 
  # include ActiveSupport::CoreExtensions::Hash::Slice
# end




# [ | Kyanite | Object | Array | Set | Enumerable | *Hash* | ]     | *Hash* |  Dictionary |
# ---
#  
#
# == *Tools* *For* *Hash*
# See TestKyaniteHash for tests and examples.
#
# === Generelle Anmerkungen zu Hashes
# Definiert man in irgendeinem Objekt die Methode <tt>==(other)</tt>, so muss man auch die Methode +hash+ neu definieren! 
#
# Rubys +delete+ und +delete_if+ verändern den Hash! Siehe TestHash#test_delete
#
#
class Hash


  if RUBY_VERSION < "1.9"
  
    # Credit: Paul Murur http://mucur.name/posts/when-is-a-set-not-a-set
    # Create a hash based on the keys and values.
    def hash
      keys.hash + values.hash + (default ? default.hash : 0)
    end

    # Credit: Paul Murur http://mucur.name/posts/when-is-a-set-not-a-set
    # To determine whether two hashes are the same, compare their hashes.
    def eql?(other)
      hash == other.hash
    end
    
  end # Ruby Version


 
  # Entfernt alle Key-Value-Paare mit <b>nil-Keys</b> in-place.
  # Tests: TestHash#test_delete
  def compact_keys!
      delete_if {|key, value| key.nil? }
  end
  
  
  # Entfernt alle alle Key-Value-Paare mit <b>nil-Values</b> in-place.
  # Tests: TestHash#test_compact
  def compact_values!
      delete_if {|key, value| value.nil? }
  end    

  
  # Entfernt das Key-Value-Paar mit einem bestimmten Key in-place. 
  # Rückgabe ist der modifizierte Hash (im Gegensatz zur +delete+-Methode, die das entfernte Key-Value-Paar zurückgibt! ).
  def delete_key(key)
    delete_if { |k,v| k == key }
  end        
  
  # Entfernt alle Key-Value-Paare mit einem bestimmten Value in-place.
  #     
  def delete_value(value)
    delete_if { |k,v| v == value }
  end
    
    
  # erzwingt ein Array der Länge 1, wenn sowohl Einzelwerte als auch Arrays erlaubt sind. 
  # Beispiel:
  #   inputoptions = options.arrayize(:skip, :debug)  
  # 
  def arrayize(*keys)
    keys.each do |k|
      if self[k]  &&  !self[k].respond_to?(:first) 
        self[k] =  [self[k]]
      end
    end
        
    self
  end
  
  
  # Greift auf den Hash mit nicht-ganz-passenden Schlüsseln zu
  #
  def fuzzyget(key, level = 3)
    try = self[key]
    return try    if try  ||  level <= 0
    try = self[key.to_s.downcase2]
    return try    if try  ||  level <= 1   
    try = self[key.to_s.mysqlize]
    return try    if try  ||  level <= 2       
  end    

  
  # Liefert die Verteilung der size 
  # oder die Verteilung der class 
  # oder die Verteilung eines anderen Merkmals der aufgezählten Elemente.
  # Siehe auch Enumerable#distribution.  
  # Die Keys des Hash werden ignoriert.
  #
  def distribution( mode = :size)
    verteilung = Hash.new
    each do | key, element |
      value = element.respond(mode)
      if verteilung.has_key?(value)
        verteilung[value] += 1
      else
        verteilung[value] = 1
      end # if      
    end #each
    verteilung.to_a.sort   
  end  
  
  
  # liefert irgendein Value  
  #
  def first
    self.each do |key, value|
      return value
    end  
  end #def
  
  
  # liefert irgendein anderes Value  
  #
  def last
    first = nil
    self.each do |key, value|
      if first.nil?
        first = value
        next
      else
        return value
      end #if
    end #do 
  end #def 
 

   
    

end #class   
 
if defined? TransparentNil
  class NilClass
    def compact_keys!;          nil;            end   
    def compact_values!;        nil;            end   
    def delete_key(*a);         nil;            end   
    def delete_value(*a);       nil;            end   
    def arrayize(*a);           nil;            end   
    def fuzzyget(*a);           nil;            end   
  end
end

    
    
    
# ---------------------------------------------------------
# Ausprobieren
#
if $0 == __FILE__ 

  test = {:b => 2, :a => 1,  :c => 3}
  see test.first
  see test.last
  
  


end
    
    
    
    
    
    
