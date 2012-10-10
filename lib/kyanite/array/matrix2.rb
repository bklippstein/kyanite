# ruby encoding: utf-8
require 'kyanite/array/array2'   

# Datenstruktur für streng-zweidimensionale Matritzen. Erbt die Methoden von Array2 und Array. Beispiele siehe TestMatrix2.
#
# Eine Matrix2 ist eine spezielle Form von Array2, sie hat <b>in jeder Zeile die gleiche Anzahl Spalten</b>.
# Jede Zeile hat einen Zeilenheader row(0), jede Spalte einen Spaltenheader column(0).
#
# Man könnte auch die Standard-Library Matrix verwenden, aber die ist langsam, fehlerhaft und eher auf numerische Werte zugeschnitten denn auf beliebige Objekte.
#      
# noch nicht implementiert: append!(top | bottom | left | right)   
class Matrix2  < Array2

    # Liefert eine bestimmte Spalte zurück.
    # Dabei wird die Matrix2 vorher mit clean4view!(0) behandelt, d.h. sie verändert sich ggf.!         
    # 
    # Tests: TestMatrix2#test_spalten
    def column(j)                                
        clean4view!(0)
        return self.transpose.at(j)
    end    
    
    
    # Setzt den Wert einer Spalte.
    # Dabei wird die Matrix2 vorher mit clean4view!(0) behandelt, d.h. sie verändert sich ggf.!      
    # 
    # Tests: TestMatrix2#test_spalten
    def set_column!(j,wert)                        
        clean4view!(0)
        transpose!    
        wertdup = wert.dup

        self[j] = wert.dup
        transpose!
        return wertdup
    end

    # Wieviele Spalten hat die Tabelle? Maßgeblich dafür ist die Header-Spalte!
    def column_size                                
        self[0].size
    end          

    
    # Liefert eine bereinigte Kopie der Matrix2.  
    # Level=0:: Resize to Header, d.h. alle Zeilen werden auf die Länge der ersten Zeile angepasst (beschnitten oder mit nil aufgefüllt) 
    # Level=1:: Zeilen ohne Zeilenheader werden gelöscht
    # Level=2:: Spalten ohne Spaltenheader werden gelöscht      
    #
    # Test: TestMatrix2#test_resize_to_header
    #
    def clean4view(level = 0)

        # Level 0 : Resize to Header, d.h. alle Zeilen werden auf die Länge der ersten Zeile angepasst (beschnitten oder mit nil aufgefüllt) 
        cs = self.column_size
        new = self.collect { |zeile| 
                                zs = zeile.size
                                if zs == cs 
                                    zeile
                                elsif zs > cs 
                                    zeile[0, cs]   
                                else # zs < cs
                                    zeile + Array.new(cs-zs) 
                                end }
        return Matrix2.new(new) if level == 0                                       # Level 0

        
        #Level 1 : Zeilen ohne Zeilenheader werden gelöscht
        new.collect!     { | zeile | zeile.row_to_nil }              
        new.compact!                                                  
        return Matrix2.new(new) if level == 1                                       # Level 1    

        
        # Level 2 : Spalten ohne Spaltenheader werden gelöscht
                new.transpose!                                
                new.collect! { | spalte | spalte.row_to_nil }              
                new.compact!                                                  
                new.transpose!
        return Matrix2.new(new)                                                     # Level 2    
    end # def clean4view

    
    # In-place-Variante von clean4view.
    def clean4view!(level = 0)
        self.replace(self.clean4view(level))
    end


end # class Matrix2  
 











    
    
    





    
    
    
    


    
    
    
    
    
    
