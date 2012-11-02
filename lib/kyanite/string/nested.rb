# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end

class String

# ---------------------------------------------------------------------------------------------------------------------------------
# @!group Nested
# See TestKyaniteStringNested for tests and examples.   
#
  
  
  # Returns the matching opposite bracket. Examples:
  #  '('.anti          ->  ')'
  #  '{'.anti          ->  '}'
  #  ']'.anti          ->  '['
  #  '<hallo>'.anti    ->  '</hallo>'
  #  '</hallo>'.anti   ->  '<hallo>'
  #
  # See tests and examples {TestKyaniteStringNested#test_010_anti here}.  
  # @return [String] opposite bracket 
  def anti
    if self.size == 1
      return self.tr('([{<)]}>',')]}>([{<')
    else
      if self =~ /<([^\/].*)>/
        return "</#{$1}>"
      elsif self =~ /<\/(.*)>/
        return "<#{$1}>"        
      end
    end
    return self
  end    
  
  
  
  # Returns the positions of the next bracket pair. Example:
  #  'Hello(welt)wort'.index_bracket  ->  5..10
  # See tests and examples {TestKyaniteStringNested#test_020_index_bracket here}.    
  # @return [Range] Positions of brackets
  # @param start [Integer] Search from this starting position
  # @param pattern [RegExp, String] Search only this type of bracket 
  #  
  def index_bracket( pattern=nil, start=0, last_found = nil )
    return nil if self.empty?
    pattern = /[{<\[]/ unless pattern    
    # pattern = /['"({<(\[]/  unless pattern 
    debug = false
    puts 'untersuche ' + self[start..-1]     if debug
    found = self.index(pattern, start) 
    puts "found=#{found}"                    if debug
    return last_found unless found
    pattern_anti = self[found..found].anti
    startpunkt = found
    loop do
      found_next =  self.index( pattern,      startpunkt+1 ) || 9999999
      found_anti =  self.index( pattern_anti, startpunkt+1 ) 
      puts "found_next=#{found_next}"        if debug
      puts "found_anti=#{found_anti}"        if debug
      break unless found_anti
      return found..found_anti   if found_anti <= found_next
      # puts
      # puts
      # puts
      # puts
      # puts
      # puts "start=#{(start).inspect_pp}"
      # puts "pattern=#{(pattern).inspect_pp}"
      # puts "found_next=#{(found_next).inspect_pp}"
      # puts "found..found_anti=#{(found..found_anti).inspect_pp}"
      rekursiv_result = self.index_bracket(pattern, found_next, found..found_anti)
      return found..found_anti unless rekursiv_result
      startpunkt = rekursiv_result.last
      puts "startpunkt=#{startpunkt}"        if debug
    end # loop
    nil
  end
  
  
  # Applies the block to a hierarchically defined substring of the string.
  #
  # See tests and examples {TestKyaniteStringNested#test_030_mask_ungeklammert here}.    
  # @return [String] 
  # @param options [Hash] 
  # @option options [Integer] :level_start
  # @option options [Integer] :level_end
  # @option options [Integer] :level_akt
  # @option options [RegExp, String] :pattern
  # @option options [Boolean] :skip_empty
  # @option options [Boolean] :param_level
  # @option options [Boolean] :with_brackets
  # @param block [Block] 
  #    
  def mask( options={}, &block )
  
    # vorbereiten
    debug = false
    result = self.dup
    
    level_start =   options[:level_start]   || 1
    level_end =     options[:level_end]     || 99999
    level_akt =     options[:level_akt]     || 0
    #level_akt += 1 if with_brackets    
    pattern =       options[:pattern]       || /[{<\[]/ # /['"({<\[]/ ist langsam
    skip_empty =    options[:skip_empty]    || false
    param_level =   options[:param_level]   || false    # übergibt dem Block zusätzlich die Nummer des aktuellen Levels
    with_brackets = options[:with_brackets] || false  # übergibt dem Block auch die Brackets, Beispiel siehe Tests!!
    
    raise ArgumentError, "level_start can't be nil"             unless level_start 
    raise ArgumentError, "level_end can't be nil"               unless level_end 
    raise ArgumentError, 'level_end has to be >= level_start'   unless level_end >= level_start
    if debug 
      puts "level_start=#{level_start}"   
      puts "level_end=#{level_end}"   
      puts "level_akt=#{level_akt}"    
      puts
    end          
    geklammert = result.index_bracket(pattern)
    puts "geklammert=#{geklammert}"  if debug
    
    
    # Los geht's: geklammert, Klammern werden nicht mit übergeben 
    if geklammert 
      if !with_brackets
        if geklammert.first > 0
          pre =   result[0..geklammert.first-1]
        else
          pre =   ''
        end
        bra =     result[geklammert.first..geklammert.first]
        mid =     result[geklammert.first+1..geklammert.last-1]
        ket =     result[geklammert.last..geklammert.last]
        if geklammert.last < (result.size-1)
          past =  result[geklammert.last+1..-1]
        else
          past =  ''
        end  
      else # with_brackets
        if geklammert.first > 0
          pre =   result[0..geklammert.first]
        else
          pre =   result[geklammert.first..geklammert.first]
        end
        bra =     ''
        mid =     result[geklammert.first+1..geklammert.last-1]
        ket =     ''
        if geklammert.last < (result.size-1)
          past =  result[geklammert.last..-1]
        else
          past =  result[geklammert.last..geklammert.last]
        end        
      end
      if debug 
        puts "1pre=#{pre}"   
        puts "1bra=#{bra}"   
        puts "1mid=#{mid}"   
        puts "1ket=#{ket}"   
        puts "1past=#{past}"   
        puts
      end     
      
      # yield
      if ( (level_start..level_end)  === level_akt  &&  (!pre.empty? || !skip_empty) )     
        if param_level
          pre =  yield(pre,level_akt)   
        else
          pre =  yield(pre) 
        end
      end # if yield
      mid =  mid.mask(  options.merge({:level_akt => level_akt+1}), &block )
      past = past.mask( options, &block )
      if debug 
        puts "2pre=#{pre}"   
        puts "2bra=#{bra}"   
        puts "2mid=#{mid}"   
        puts "2ket=#{ket}"   
        puts "2past=#{past}"   
        puts
      end
      
      return (pre||'') + bra + (mid||'') + ket + (past||'')

      
    
    # Los geht's: keine Klammern
    else
      # yield
      
      if ( (level_start..level_end)  === level_akt  &&  (!result.empty? || !skip_empty ) ) 

        puts "result=#{result}\n" if debug
        if param_level
          result =  yield(result,level_akt)   
        else
          result=  yield(result) 
        end      
      end # if yield
    return (result||'')       
    end      

    raise 'no go'
      
  end # def



  # Returns the depth of nesting (number of nesting levels). 
  # @return [Integer] Depth of nesting 
  # @param pattern [RegExp, String] Search only this type of bracket  
  def nestinglevel(pattern=/[{<(\[]/)
    result = 0
    self.mask( :level_start => 0,
               :pattern => pattern,
               :param_level => true ) { |s,l| 
               if l > result
                result = l
                s
               else
               s
               end
               }
    result
  end

  
  


  

end # class


if defined? TransparentNil
  class NilClass
    
    # Rückgabe: 0
    def nestinglevel;               0;              end   
    
    def anti;                       nil;            end
    def index_bracket;              nil;            end
    def mask(*a);                   nil;            end
  end
end


# ------------------------------------------------------------------------------
#  Tests
#    


if $0 == __FILE__ 

  

end # if































