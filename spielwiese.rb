# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end



  require 'perception'
        see "Hallo"




  require 'perception'
        my_caller  = CallerUtils.mycaller(:skip => ['perception', 'ruby\gems', 'ruby/gems', 'test/unit']) 
        my_maindir = CallerUtils.mycaller_maindir(my_caller)            if my_caller
        see my_maindir