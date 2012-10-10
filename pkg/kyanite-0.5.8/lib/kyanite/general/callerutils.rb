# ruby encoding: utf-8
require 'kyanite/string/include'



# [ | Kyanite | *Object* | Array | Set | Enumerable | Hash | ]     | *Object* | String | Symbol | Numeric |  
# [ ] | Object | KKernel | *CallerUtils* | Undoable | Class |
#
# ---
#
#
# == *Tools* *for* Kernel#caller
#
class CallerUtils

  # Untersucht den Call-Stack. Liefert die Größe des Stacks oder den letzten Eintrag.
  #
  # Options: 
  #   :skip    Ignoriere caller, die das angegebene Fragment enthalten   (String oder Array)
  #   :mode    Welche Art von Ergebnis soll geliefert werden? 
  #            :caller (Standard) liefert den Caller, 
  #            :size liefert die Größe das Call-Stacks
  #
  # Beispiel:        
  #  CallerUtils.mycaller(:skip => ['perception', 'ruby\gems', 'ruby/gems', 'test/unit'])
  #  => "R:/_Eigene_Projekte_unter_SVN/kyanite/lib/kyanite/general/callerutils.rb:100"
  #       
  def self.mycaller(options={})
    skip = options[:skip] || []
    skip = [skip]   if skip.kind_of?(String)
    mode = options[:mode] || :caller
    result = nil     
    size = caller.size  
    if skip.empty?
      return caller[0]  if mode == :caller
      return size       if mode == :size
    end
    caller.each_with_index do | c, i |
#puts "caller=#{c}"
#puts "skip=#{skip.inspect_pp}"
      next if c.include?(skip)
#puts "ok! \n"
      if mode == :caller
        result = c
      elsif mode == :size
        result = (size - i)
      end # if mode           
      break
    end # each caller
    # puts "mycaller=#{result}"  
    result
  end # def


  
  # Ermittelt das Hauptverzeichnis eines Callers auf heuristischem Wege.
  # Der Name des Hauptverzeichnisses entspricht meist dem Namen der Applikation oder Library.
  #
  # Beispiel:
  #   my_caller  = CallerUtils.mycaller(:skip => ['perception', 'ruby\gems', 'ruby/gems', 'test/unit']) 
  #   CallerUtils.mycaller_maindir(my_caller)           
  #   => "R:/_Eigene_Projekte_unter_SVN/kyanite"
  #
  def self.mycaller_maindir(mycaller)
    dir_caller =File.dirname(mycaller)
    array_caller = dir_caller.split('/')
    array_caller = dir_caller.split("\\") if array_caller.size == 1
#require 'pp'
#pp array_caller
    indicatorfiles = %W{Init Boot History License Manifest Rakefile README ReadMe Readme Setup}
    check = []
    (-array_caller.size).upto(-1) do |lev|
      indicatorfiles.each do | f |
        next if array_caller[lev..lev] == '..'
        check << array_caller[0..lev].join('/') + "/#{f}.rb"
        check << array_caller[0..lev].join('/') + "/#{f}.txt"
        check << array_caller[0..lev].join('/') + "/#{f}"
        check << array_caller[0..lev].join('/') + "/#{f.downcase}.rb"
        check << array_caller[0..lev].join('/') + "/#{f.downcase}.txt"
        check << array_caller[0..lev].join('/') + "/#{f.downcase}"          
      end
    end  
      #return check
      maindir = ''
      check.uniq.each do | try |
        # puts "try #{try}"
        maindir = try
        break if File.exist?(try)
      end
      # puts "mycaller_maindir=#{File.dirname(maindir) }"
      return File.dirname(maindir) 
    end    
  
  
  # def self.caller_full(options={})
    # caller
  # end  
  
  
end # class



# ==================================================================================
# Ausprobieren
#
if $0 == __FILE__ 

           
           
           
        require 'pp'
        my_caller  = CallerUtils.mycaller(:skip => ['perception', 'ruby\gems', 'ruby/gems', 'test/unit']) 
        my_maindir = CallerUtils.mycaller_maindir(my_caller)            if my_caller
        pp my_maindir







end













