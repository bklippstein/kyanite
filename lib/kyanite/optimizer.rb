# ruby encoding: utf-8
 
#
# [ | *Kyanite* | Object | Array | Set | Enumerable | Hash | ]     | Kyanite | TrueClass | FalseClass | NilClass | *Div* | 
# [ ] | Div | Tree::TreeNode | *Optimizer* | 
# ---
#
# == *Optimizer* 
# Auswahl von Objekten auf Basis von Scores. See TestKyaniteOptimizer for Tests and examples.
#
# Jedes Objekt wird per +push+ in den Optimizer geschrieben. Dabei wird auch sein Score übergeben.
# +content_max+ bzw. +content_min+ liefern das Objekt mit dem höchsten / niedrigsten Score. 
# +delete_max+ bzw. +delete_min+ löschen das Objekt mit den höchsten / niedrigsten Score. Dadurch ist auch der Zugriff auf die zweiten und dritten Objekte möglich. 
#
# Drei Stufen für Marshall sind denkbar:
# * kein Marshal
# * Marshal.load(Marshal.dump) beim Schreiben. Dadurch sind Schreibzugriffe teuer, Lesezugriffe aber billig
# * Marshal.dump beim Schreiben, Marshal.load beim Lesen. Dadurch sind Lese- und Schreibzugriffe teuer, 
#   die im Optimizer gespeicherten Objekte sind aber abgeschottet und geschützt.
#
class Optimizer < Hash

#@@marshal = true

  # def initialize( options={} )
    # @@marshal = options[:marshal]  || true
  # end
  
  
  # Liefert den Wert des höchsten Scores.
  def score_max
    return nil  if size == 0  
    keys.max
  end
  
  
  # Liefert den Wert des niedrigsten Scores.  
  def score_min
    return nil  if size == 0  
    keys.min
  end  
  
  
  # Liefert den Content mit dem höchsten Score. Mit
  # [] content_max(0)      erhält man den ersten Content mit maximalem Score, mit
  # [] content_max(-1)     den letzten Content mit maximalem Score und mit 
  # [] content_max(0..-1)  alle Contents mit maximalem Score (dann als Array).
  #
  def content_max(range=0..0)
    return nil  if size == 0
    range = (range..range) if range.kind_of?(Fixnum)    
    if (range.end - range.begin) == 0
      return Marshal.load(self[keys.max][range.begin])
    else
      result = []
      self[keys.max][range].each do | m |
        result << Marshal.load(m)
      end
      return result
    end
  end
  
  
  # siehe #content_max
  def content_min(range=0..0)
    return nil  if size == 0
    range = (range..range) if range.kind_of?(Fixnum)    
    if (range.end - range.begin) == 0
      return Marshal.load(self[keys.min][range.begin])
    else
      result = []
      self[keys.min][range].each do | m |
        result << Marshal.load(m)
      end
      return result
    end
  end 
  
  
  # Beladen des Optimizers mit Objekten.
  def push( score, content, options={} )
    if self.has_key?(score) 
      self[score] << Marshal.dump(content) 
    else
      self[score] = [ Marshal.dump(content) ]
    end
  end
  
  
  # Löscht alle Objekte in der Mitte.
  def cleanup
    return false if size <= 2
    keys.sort[1..-2].each do | key | 
      self.delete(key)
    end
    true
  end
  
  
  # Löscht das Objekt mit dem niedrigsten Score.   
  def delete_min
    return false if size <= 1
    self.delete(keys.min)
    true
  end  
  
  # Löscht das Objekt mit dem höchsten Score.     
  def delete_max
    return false if size <= 1
    self.delete(keys.max)
    true
  end    



  


end #class














