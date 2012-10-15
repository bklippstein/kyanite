# ruby encoding: utf-8
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'rubytree'
require 'transparent_nil'  


module Tree #:nodoc: 

  # [ | *Kyanite* | Object | Array | Set | Enumerable | Hash | ]     | Kyanite | TrueClass | FalseClass | NilClass | *Div* | 
  # [ ] | Div | <b>Tree::TreeNode</b> | Optimizer | 
  # ---
  #
  # == Ergänzungen zu rubytree
  # See TestKyaniteTree for tests and examples.
  #
  class TreeNode
    attr_reader :childrenHash
   
    
    # kann jetzt auch mit Symbolen umgehen
    def to_s
      ":#{@name}"
      # "Node Name: #{@name}" +
        # " Content: #{@content || '<Empty>'}" + 
        # " Parent: #{(isRoot?()  ? '<None>' : @parent.name)}" + 
        # " Children: #{@children.length}" +
        # " Total Nodes: #{size()}"
    end  
    
    
    # funktioniert jetzt  
    def print_tree(level = 0, breite = 8)

      if is_root? 
        print "*"
        
      elsif level == 0
        print 'X'
      
      else
        print "|" unless parent.is_last_sibling?
        print(" " * (level - 1 ) * breite)
        print(is_last_sibling? ? "+" : "|")
        print "---"
        print(has_children? ? "+" : ">")
      end

      puts " #{name}"

      children { |child| child.print_tree(level + 1)}
      nil
    end    
    
    
    # anders als [] wird der gesamte Baum durchsucht
    # Liefert den ersten Treffer 
    def find( node_name )
      return self               if self.name == node_name
      result = self[node_name]
      return result if result
      children do |c| 
        next if c.children.empty?
        #puts "durchsuche #{c.name}"
        result = c.find(node_name)
        return result if result
      end
      nil
    end
    
    
    # Funktioniert nicht
    # Liefert ein Array aller untergeordneten Child-Keys. 
    # Es wird der gesamte Baum durchsucht.
    # def all_child_keys
      # result = @childrenHash.keys || []
        # children do |c| 
        # puts "durchsuche #{c}"
          # next if c.childrenHash.empty?
          # result += c.all_child_keys
        # end      
      # result
    # end
    
    
    
    
    
    
  end # class
end # module  





# ==================================================================================
# Ausprobieren
#
if $0 == __FILE__ 

    # Oberste Ebene
    ttroot =  Tree::TreeNode.new(:root)
    ttroot << Tree::TreeNode.new(:ta_item)       
    ttroot << Tree::TreeNode.new(:ta_num) 
    ttroot << Tree::TreeNode.new(:ta_site) << Tree::TreeNode.new(:ta_url) 
    ttroot << Tree::TreeNode.new(:ta_sonstiges)  

    # :singlechar
    ttroot << Tree::TreeNode.new(:singlechar)        
                          ttroot[:singlechar] << Tree::TreeNode.new(:ta_struktur) << Tree::TreeNode.new(:ta_punkt) << Tree::TreeNode.new(:wa_satzende) 
                          ttroot[:singlechar] << Tree::TreeNode.new(:ta_minus) 
                          ttroot[:singlechar] << Tree::TreeNode.new(:ta_sonderzeichen)  

    # :item    
    ttroot[:ta_item] << (wa_word=Tree::TreeNode.new(:wa_word)) << Tree::TreeNode.new(:wa_name)    
                        wa_word << Tree::TreeNode.new(:wa_abbrev)   
                        wa_word << Tree::TreeNode.new(:wa_multi)   
                        
    #ttroot.print_tree
    


end




 


    
    
    
    
    
    
    
    
    
