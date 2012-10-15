# ruby encoding: utf-8

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
  STRING_RANDOM_BASIS = string_random_basis
end

class String

  # ---------------------------------------------------------------------------------------------------------------------------------
  # :section: Random
  #  

    # Zufällige Reihenfolge
    def shuffle(separator=//)
      split(separator).shuffle.join('')
    end

    # In-place-Variante von shuffle
    def shuffle!(separator=//)
      self.replace( shuffle(separator) )
    end

    
    def String.random( type=:de, size=16)
      (0...size).map { STRING_RANDOM_BASIS[type][Kernel.rand(STRING_RANDOM_BASIS[type].size)] }.join    
    end    

end

if defined? TransparentNil
  class NilClass
    def shuffle;                      nil;            end
    def shuffle!;                     nil;            end    
  end
end
