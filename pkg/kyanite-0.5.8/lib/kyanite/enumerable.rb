# ruby encoding: utf-8  
unless defined? ENUMERABLE_REQUIRED
  ENUMERABLE_REQUIRED=true
end

require 'kyanite/enumerable/enumerable_enumerables'
require 'kyanite/enumerable/enumerable_numerics'
require 'kyanite/enumerable/enumerable_strings'
require 'kyanite/enumerable/structure' 



if $0 == __FILE__ 
  puts ENUMERABLE_REQUIRED
end


