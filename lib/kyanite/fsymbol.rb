# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end
require 'kyanite/tree'  




# @!macro fsymbol
class FSymbol

  attr_accessor :value
  attr_accessor :childs
  @@instance_cache = {}
  @@def_tree_cache = nil
  
  # @private  
  def self.instance_cache
    @@instance_cache
  end
  

    
    
  
  def initialize( value, def_tree=nil)
    raise ArgumentError, 'Value darf nicht nil sein!'       if value.nil?    
    @value = value    
    
    if @@instance_cache[value]
      @childs = @@instance_cache[value].childs 
      return @@instance_cache[value] 
    end
    
    if def_tree.nil?
      def_tree = @@def_tree_cache
    else
      @@def_tree_cache = def_tree
    end
    tree = def_tree.find(value) || nil
    raise ArgumentError, "FSymbol konnte nicht erzeugt werden. Value :#{value} nicht im Definitionstree gefunden."       if tree.nil? 
    
    @childs = tree.all_child_keys    
    @@instance_cache[value] = self
    self
  end  
  
  
  def to_s
    @value.to_s
  end
  
  
  def inspect
    @value.inspect
  end  

  
  def <=>(other)
    return nil       if other.nil?
    other = other.to_fsymbol  unless other.class == FSymbol
    return 0   if @value == other.value    
    return -1  if @childs.include?(other.value)
    return 1   if other.childs.include?(@value) 
    return nil
  end   
    
  
  def ==(other)
    return nil       if other.nil?
    begin
      (self <=> other) == 0
    rescue
      nil
    end
  end  
  
  
  def <=(other)
    return nil       if other.nil?
    begin
      c = (self <=> other)
      (c == -1 || c == 0)
    rescue
      nil
    end
  end  
  
  
  def >=(other)
    return nil       if other.nil?
    begin
      c = (self <=> other)
      (c == 1 || c == 0)
    rescue
      nil
    end
  end    

  
  def nil?
    return true if @value.nil?
    false
  end
  
  
end



# -----------------------------------------------------------------------------------------
# Interface für Symbol
#
class Symbol
   
  def to_fsymbol(def_tree=nil)
    FSymbol.new(self, def_tree)
  end
 
end






# -----------------------------------------------------------------------------------------
# Ausprobieren
#
if $0 == __FILE__ then

  require 'perception'  

  unless defined? DEF_TREE
      # Oberste Ebene
      ttroot = Tree::TreeNode.new(:root)
      ttroot << Tree::TreeNode.new(:item)       
      ttroot << Tree::TreeNode.new(:num) 
      ttroot << Tree::TreeNode.new(:site) << Tree::TreeNode.new(:url) 
      ttroot << Tree::TreeNode.new(:sonstiges) 
      
      # :singlechar
      ttroot << Tree::TreeNode.new(:singlechar)        
                            ttroot[:singlechar] << Tree::TreeNode.new(:struktur) << Tree::TreeNode.new(:punkt) << Tree::TreeNode.new(:satzende) 
                            ttroot[:singlechar] << Tree::TreeNode.new(:minus) 
                            ttroot[:singlechar] << Tree::TreeNode.new(:sonderzeichen)  
      
     # :item    
      ttroot[:item] << (wa_word=Tree::TreeNode.new(:de)) << Tree::TreeNode.new(:name)    
                          wa_word << Tree::TreeNode.new(:abbrev)   
                          wa_word << Tree::TreeNode.new(:multi)   
      
      
      DEF_TREE = ttroot   
    # see DEF_TREE.print_tree     
  end    


  see :item.to_fsymbol(DEF_TREE)
  see :item.to_fsymbol(DEF_TREE)
  see :singlechar.to_fsymbol(DEF_TREE)
  see :singlechar.to_fsymbol(DEF_TREE)
  see FSymbol.instance_cache



end







