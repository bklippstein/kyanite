# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end

require 'active_support/core_ext/hash/slice'          # Slice a hash to include only the given keys. 
require 'active_support/core_ext/hash/reverse_merge'  # Merges the caller into +other_hash+. 
require 'kyanite/enumerable'                          # is_collection?

# class Hash
  # include ActiveSupport::CoreExtensions::Hash::ReverseMerge 
  # include ActiveSupport::CoreExtensions::Hash::Slice
# end






# @!macro hash
class Hash


  # Deletes all key-value pairs with <b>nil-keys</b> in-place.
  # @return [Hash] in-place modificated
  def compact_keys!
      delete_if {|key, value| key.nil? }
  end
  
  
  # Deletes all key-value pairs with <b>nil-values</b> in-place.
  # @return [Hash] in-place modificated 
  def compact_values!
      delete_if {|key, value| value.nil? }
  end    

  
  # Deletes the key-value pair with a <b>given key</b> in-place. 
  # Returns the modificated hash (in contrast to Rubys +delete+ method that returns the deleted key-value pair! ).
  # @return [Hash] in-place modificated 
  def delete_key(key)
    delete_if { |k,v| k == key }
  end        
  
  # Deletes all key-value pairs with a <b>given value</b> in-place. 
  # Returns the modificated hash (in contrast to Rubys +delete+ method that returns the deleted key-value pair! ).
  # @return [Hash] in-place modificated 
  def delete_value(value)
    delete_if { |k,v| v == value }
  end
    
  
  # Forces some options in a methods options hash to be an array. 
  # Useful if both individual values ​​and arrays are allowed as an input option.
  #
  # Example:
  #  options = { :skip => 1, :debug => true, :test => false }
  #  puts options 
  #  => {:skip=>1, :debug=>true, :test=>false}
  #
  #  options.arrayize!(:skip, :debug)
  #  puts options 
  #  => {:skip=>[1], :debug=>[true], :test=>false}
  # 
  # @return [Hash]
  # @param keys [Key, Array of keys] Keys to process 
  def arrayize!(*keys)
    keys.each do |k|
      if self[k]  &&  !self[k].respond_to?(:first) 
        self[k] =  [self[k]]
      end
    end
        
    self
  end
  
  
  # Accesses the hash with keys that do not match exactly
  #
  def fuzzyget(key, level = 3)
    try = self[key]
    return try    if try  ||  level <= 0
    try = self[key.to_s.downcase2]
    return try    if try  ||  level <= 1   
    try = self[key.to_s.mysqlize]
    return try    if try  ||  level <= 2       
  end    

  
  # Returns the distribution of +size+, +class+ or any other characteristic of the enumerated elements.
  # The keys of the hash will be ignored. See also {Enumerable#distribution}, examples there.
  # @return [Array]
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
  
  

  # @return any value
  def first
    self.each do |key, value|
      return value
    end  
  end #def
  
  
  # @return any other value
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
 

  # if RUBY_VERSION < "1.9"
  
    # Credit: Paul Murur http://mucur.name/posts/when-is-a-set-not-a-set
    # Create a hash based on the keys and values.
    # def hash
      # keys.hash + values.hash + (default ? default.hash : 0)
    # end

    # Credit: Paul Murur http://mucur.name/posts/when-is-a-set-not-a-set
    # To determine whether two hashes are the same, compare their hashes.
    # def eql?(other)
      # hash == other.hash
    # end
    
  # end # Ruby Version   
    

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

  require 'perception'
  
  options = { :skip => 1, :debug => true, :test => false }
  puts options
  options.arrayize!(:skip) 
  puts options


  
  


end
    
    
    
    
    
    
