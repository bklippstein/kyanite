# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end


# @!macro numeric
class Integer

  # Converts a number of seconds-since-1970 in a Time object
  # @return [Time]  
  def to_time
    return nil if self > 2099999999     # geht leider nur bis ins Jahr 2036 
    ::Time.at(self)                     # ohne die Doppelpunkte sucht Ruby die Methode at in ::Time und wirft einen Error
  end     
  
  
    # +self+, you can not dup Integers
    # @return [self]
  def dup;                            self;            end        
  
end # class


if defined? TransparentNil
  class NilClass
    def to_time;                        nil;            end   
  end
end


