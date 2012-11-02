# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
end

require 'kyanite/string/include'




# @!macro caller_utils
class CallerUtils

  # Examines the call stack, returns the size of the stack, or the last caller.
  # @param options [Hash] Options
  # @option options [String, Array] :skip Ignore caller that contain the specified fragment 
  # @option options [Symbol] :mode What kind of result is to be returned? +:caller+ (default) returns the caller, +:size+ returns the size of the call stack.
  #
  # Example:
  #  CallerUtils.mycaller(:skip => ['ruby\gems', 'ruby/gems', 'test/unit']) 
  #  => "C:/Ruby-Projekte/kyanite/lib/kyanite/general/callerutils.rb:110:in `<main>'"
  #
  #  CallerUtils.mycaller(:skip => ['ruby\gems', 'ruby/gems', 'test/unit'], :mode=> :size) 
  #  => 1
  #     
  # @return [String, Integer]
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


  

  # Determines the root directory of a caller on heuristic way. The name of the main directory is usually the name of the application or library.
  # Example:
  #   my_caller  = CallerUtils.mycaller(:skip => ['ruby\gems', 'ruby/gems', 'test/unit']) 
  #   CallerUtils.mycaller_maindir(my_caller)           
  #   => "C:/Ruby-Projekte/kyanite"
  #
  # @return [String]  
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

           
           
           

my_caller  = CallerUtils.mycaller(:skip => ['ruby\gems', 'ruby/gems', 'test/unit']) 
#puts my_caller  
puts CallerUtils.mycaller_maindir(my_caller)            if my_caller








end













