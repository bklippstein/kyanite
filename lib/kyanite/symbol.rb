# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end



class Symbol

# @!group Core Extensions  

    # false
    # @return false    
    #def empty?;                         false;           end  
    
    # +self+, you can not dup Symbols
    # @return [self]
    def dup;                            self;            end  
    
    # like String method with same name
    # @return [Symbol]
    def +(other)
      (self.to_s + other.to_s).to_sym
    end
    
    # like String method with same name
    # @return [Array]    
    def *(n)
      result = []
      n.times do
        result << self
      end # do
      return result
    end #def    
    
    # like String method with same name
    # @return [Boolean]    
    # def <=>(other)
      # self.to_s <=> other.to_s
    # end
    
    # like String method with same name   
    # @return [Integer]
    # def size
      # self.to_s.size
    # end
    
end 


