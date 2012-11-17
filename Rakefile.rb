# ruby encoding: utf-8
# ü
require 'drumherum'
smart_init
require 'version' 
require 'yard'
require 'drumherum/rake'
YARD::Rake::YardocTask.new

Drumherum.github_username = 'bklippstein'
require 'kyanite'


#  ----------------------------------------------------------------------------------------------
#  Hoe
#  
# http://nubyonrails.com/articles/tutorial-publishing-rubygems-with-hoe
#
$hoe = Hoe.spec Drumherum.project_name do 

  # self.rubyforge_name = 'yourgemx' # if different than 'yourgem'
   
  developer('Bjoern Klippstein', 'klippstein@klippstein.com')
  summary               = 'General toolbox like Facets or ActiveSupport.'  
  extra_deps            << ['drumherum',                '>= 0.1.34']  
  extra_deps            << ['transparent_nil',          '>= 0.1.20']
  extra_deps            << ['activesupport',            '>= 3.2.8']
  extra_deps            << ['facets',                   '>= 2.9.3']
  extra_deps            << ['rubytree',                 '>= 0.8.3'] 
  extra_deps            << ['yard',                     '>= 0.8.3'] 
  extra_deps            << ['yard_klippstein_template', '>= 0.0.37'] 
  extra_deps            << ['hashery',                  '>= 2.0.1'] 
  extra_deps            << ['unicode_utils',            '>= 1.4.0'] 
  remote_rdoc_dir = '' # Release to root only one project  
  urls                  = [[Drumherum.url_docs], [Drumherum.url_source]]
                    
end



#  ----------------------------------------------------------------------------------------------
#  Hide Tasks
#  
 
 hide_tasks [ :announce, :audit, :check_extra_deps, :clobber_docs, :clobber_package, :default ]
 hide_tasks [ :dcov, :debug_email, :docs, :gem, :git_add, :git_commit, :git_push, :install_gem ]
 hide_tasks [ :newb, :package, :post_blog, :publish_docs, :release, :release_sanity, :release_to_gemcutter ]
 hide_tasks [ :repackage, :ridocs, :sleep_15, :sleep_5, :utf8, :yard, :yard_post ]



  
  



