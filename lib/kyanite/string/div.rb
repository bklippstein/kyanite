# ruby encoding: utf-8


class String

  # ---------------------------------------------------------------------------------------------------------------------------------
  # :section: Div
  #  

  # Wörter zählen
  def count_words
    n = 0
    scan(/\b\S+\b/) { n += 1}
    n
  end     
  

end


if defined? TransparentNil
  class NilClass

    # Rückgabe: 0
    def count_words;                   0;          end  
    
  end
end