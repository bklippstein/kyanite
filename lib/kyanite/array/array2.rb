# ruby encoding: utf-8
require 'kyanite/array/array'   
   
class Array 

  # Liefert nil, wenn das erste Element empty ist, sonst self.
  # Wird von Array2 und Matrix2 verwendet.
  # Tests: TestMatrix2#test_fehlerhalte_matrix  
  #
  def row_to_nil #:nodoc:
      return nil if self[0].empty?
      return self
  end       

end   

if defined? TransparentNil
  class NilClass 
    def row_to_nil;           nil;              end    
  end
end

# Ein Array2 ist eine spezielle Form von Array, nämlich immer zweidimensional. Siehe auch Matrix2!   
# 
# Ein Array2 kann <b>in jeder Zeile eine verschiedene Anzahl Spalten </b> haben (im Gegensatz zu Instanzen der Klasse Matrix2!)
# Jede Zeile hat einen Zeilenheader (Zelle 0), einen Spaltenheader gibt es nicht.
class Array2 < Array 

    
    
    # Schreibt den Wert einer Zelle. Siehe auch set_row! und set_column!
    # Stattdessen kann man auch schreiben:
    #  myarray[r][c] = neuerwert  
    #
    # Tests: TestMatrix2#test_matrix_zellen_und_zeilen
    def set_element!(i,j,wert)                    
        self[i][j] = wert.dup
    end        
    
    
    # Liefert eine bestimmte Zeile zurück.
    #
    # Tests: TestMatrix2#test_matrix_zellen_und_zeilen    
    def row(i)                                    
        return self.at(i)
    end        
    
    
    # Setzt den Wert einer Zeile.
    #
    # Tests: TestMatrix2#test_matrix_zellen_und_zeilen    
    def set_row!(i,wert)                        
        self[i] = wert.dup
    end        
    
    
    # Wieviele Zeilen hat das Array2?
    #
    # Tests: TestMatrix2#test_matrix_zellen_und_zeilen    
    def row_size                                
        size
    end   



    # Gibt das Array2 menschenlesbar aus. 
    # Beispielaufruf: 
    #  pp germany.adms_and_orte.inspect
    def inspect
        analyze = Array.new
        analyze = self.collect do | zeile | 
                                    ( zeile.collect { | zelle | zelle.inspect } ).join("  |  ")
                                end # zeile
        return analyze
    end # inspect  
    
    
    # Liefert eine bereinigte Kopie des Array2.  
    # Level=0:: Platzhalter für den More-Link durch echten More-Link ersetzen
    # Level=1:: Zeilen ohne Zeilenheader werden gelöscht    
    #        
    def clean4view(level = 0)
        new = self.collect { |zeile| 
                                if zeile[1].nil? && level >= 1
                                    nil
                                elsif zeile[-1] == :more  
                                    zeile[0..-2] << zeile[0].dup.more!
                                else
                                    zeile
                                end
                              }
        return Array2.new(new.compact)
    end # clean4view    

    
    
    # In-place-Variante von clean4view.
    def clean4view!(level = 0)
        self.replace(self.clean4view(level))
    end
    
end # class Array2    






    
    
    
    
    
    








    
    
    





    
    
    
    


    
    
    
    
    
    
