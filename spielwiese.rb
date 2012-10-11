
puts "Hallo"

module Kyanite #:nodoc
  module_function
  def github_username; @github_username; end
  def github_username= v; @github_username = v; end
  
end



puts Kyanite.github_username



  