# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end


module Enumerable

 # In-place-variant of +transpose+. 
  def transpose!
      self.replace(self.transpose)
  end    


end





# @!macro enum_of_enums
module EnumerableEnumerables

  # Makes the Enumerable rectangular (= strict two-dimensional). The first row is essential. 
  #
  # See tests and examples {TestKyaniteEnumerableEnumerables#test_rectangle1 here}.
  def rectangle
    qsize = self[0].size   
    result = ArrayOfEnumerables.new
    self.each do |zeile|
      size_diff = qsize - zeile.size  
      # so lassen oder zuschneiden      
      if size_diff <= 0
        result << zeile[0..qsize-1]
      # ergänzen
      else
        result << zeile + ([nil] * size_diff)
      end # if
    end # each zeile   
    result
  end # def

end




# @!macro enum_of_enums
class ArrayOfEnumerables < Array   
  include EnumerableEnumerables
end


class Array

  # @!group Cast
  # Returns {ArrayOfEnumerables} (this is an {Array} with modul {EnumerableEnumerables} included)
  # @return [ArrayOfEnumerables]    
  def to_array_of_enumerables
    ArrayOfEnumerables.new(self)
  end
  #@!endgroup
  
end


if defined? TransparentNil
  class NilClass
    def transpose!;                     nil;            end  
    def transpose;                      nil;            end  
    def rectangle;                      nil;            end  
  end
end





