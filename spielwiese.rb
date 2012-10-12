
# puts "Hallo"



require 'kyanite'




Kyanite.projectname = 'kyanite'

puts Kyanite.projectname.to_class.const_get('VERSION')



  