# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end


class String

  unless defined? STRING_RANDOM_BASIS
    string_random_basis = Hash.new
    
    password = [('0'..'9'),('A'..'Z'),('a'..'z')].map {|range| range.to_a}.flatten   
    string_random_basis[:password] = password
    
    de_hauf = [ [ 'ß', 3 ],
                [ 'ä', 5 ],
                [ 'ö', 3 ],
                [ 'ü', 8 ],    
                [ 'a', 51 ],
                [ 'b', 19 ],
                [ 'c', 30 ],
                [ 'd', 51 ],
                [ 'e', 174 ],
                [ 'f', 17 ],
                [ 'g', 30 ],
                [ 'h', 48 ],
                [ 'i', 76 ],
                [ 'j', 3 ],
                [ 'k', 12 ],
                [ 'l', 34 ],
                [ 'm', 25 ],
                [ 'n', 98 ],
                [ 'o', 23 ],
                [ 'p', 8 ],
                [ 'q', 1 ],    
                [ 'r', 70 ],
                [ 's', 72 ],
                [ 't', 61 ],
                [ 'u', 40 ],
                [ 'v', 7 ],
                [ 'w', 19 ],
                [ 'x', 1 ],
                [ 'y', 1 ],
                [ 'z', 11 ]]
    de_array = []
    de_hauf.each do | buchstabe, haufigkeit |
      de_array +=  [buchstabe]*haufigkeit
    end      
    string_random_basis[:de] = de_array
    
    en_hauf = [ [ 'a', 51 ],
                [ 'b', 19 ],
                [ 'c', 30 ],
                [ 'd', 51 ],
                [ 'e', 174 ],
                [ 'f', 17 ],
                [ 'g', 30 ],
                [ 'h', 48 ],
                [ 'i', 76 ],
                [ 'j', 3 ],
                [ 'k', 12 ],
                [ 'l', 34 ],
                [ 'm', 25 ],
                [ 'n', 98 ],
                [ 'o', 23 ],
                [ 'p', 8 ],
                [ 'q', 1 ],    
                [ 'r', 70 ],
                [ 's', 72 ],
                [ 't', 61 ],
                [ 'u', 40 ],
                [ 'v', 7 ],
                [ 'w', 19 ],
                [ 'x', 1 ],
                [ 'y', 1 ],
                [ 'z', 11 ]]
    en_array = []
    en_hauf.each do | buchstabe, haufigkeit |
      en_array +=  [buchstabe]*haufigkeit
    end      
    string_random_basis[:en] = en_array  
    
    STRING_RANDOM_BASIS = string_random_basis
  end


  # ---------------------------------------------------------------------------------------------------------------------------------
  # @!group Random
  #  

    # Reorder string in random order. Example:
    #  "Random order".shuffle
    #  => "oeo rdRdnmar"
    # @return [String]
    def shuffle(separator=//)
      split(separator).shuffle.join('')
    end

    # In-place-variant of {#shuffle +shuffle+}. 
    # @return [String]     
    def shuffle!(separator=//)
      self.replace( shuffle(separator) )
    end

    # Generates a random string. 
    # Example:
    #  String.random( :de, 20)
    #  => brräbkpßrdirnenshrnh
    #
    #  String.random( :en, 20)
    #  => euduwmtenohrtnaeewsc
    #
    #  String.random( :password, 20)
    #  => PzAAGW2ALsbJRnljI6ho    
    #
    # @param type [Symbol] Char base with letter frequency of the random string (+:de+, +:en+ or +:password+)
    # @param size [Integer] Length of the random string
    # @return [String] Random string    
    def String.random( type=:en, size=16)
      (0...size).map { STRING_RANDOM_BASIS[type][Kernel.rand(STRING_RANDOM_BASIS[type].size)] }.join    
    end    

end

if defined? TransparentNil
  class NilClass
    def shuffle;                      nil;            end
    def shuffle!;                     nil;            end    
  end
end


# -----------------------------------------------------------------------------------------
# Ausprobieren
#
if $0 == __FILE__ then

    puts String.random( :password, 20)  



end
