# ruby encoding: utf-8
# ü
# Required alle Kyanite-Libs
# -- eine Auswahl der wichtigsten Kyanite-Libs required man mit 
# require 'kyanite/basics'

# @!macro [new] navigation
#  {Object} {String} {Class} {Symbol} 
#  {Integer} {Float} 
#  {Range}
#  {Array} 
#  {Set} 
#  {Dictionary} {Hash}
#  {Tree::TreeNode Tree} {Optimizer} {Undoable} {CallerUtils}


# @!macro [new] array
#  === Array Additions
#  [Kyanite definitions] {Array} 
#  [Kyanite tests and examples] {TestKyaniteArray}    
#  [Usage] +require 'kyanite/array'+


# @!macro [new] dictionary
#  === Dictionary Additions
#  [Kyanite definitions] {Dictionary}, {Hash}
#  [Kyanite tests and examples] {TestKyaniteDictionary}    
#  [Base class] {http://rubydoc.info/github/rubyworks/hashery/master/Hashery/Dictionary +Hashery::Dictionary+} (A Dictionary is a Hash that preserves order.)
#  [Usage] +require 'kyanite/dictionary'+
#

# @!macro [new] enum_of_enums
#  === Enumeration Of Enumerations
#  Two-dimensional enumerables or enumerables of objects, which are enumerable.
#
#  [Kyanite definitions] {EnumerableEnumerables} 
#  [Kyanite class with module included] {ArrayOfEnumerables}
#  [Kyanite tests and examples] {TestKyaniteEnumerableEnumerables}    
#  [Usage] +require 'kyanite/enumerable/enumerable_enumerables'+ 
#

# @!macro [new] enum_of_numerics
#  === Enumeration Of Numerics
#  [Kyanite definitions] {EnumerableNumerics} 
#  [Kyanite class with module included] {ArrayOfNumerics}
#  [Kyanite tests and examples] {TestKyaniteEnumerableNumerics}    
#  [Usage] +require 'kyanite/enumerable/enumerable_numerics'+
#

# @!macro [new] enum_of_strings
#  === Enumeration Of Strings
#  [Kyanite definitions] {EnumerableStrings} 
#  [Kyanite class with module included] {ArrayOfStrings}
#  [Kyanite tests and examples] {TestKyaniteEnumerableStrings}    
#  [Usage] +require 'kyanite/enumerable/enumerable_strings'+
#

# @!macro [new] enumerable
#  === Enumerable Additions
#  [Kyanite definitions] {Enumerable} 
#  [Kyanite tests and examples] {TestKyaniteEnumerableStructure}    
#  [Usage] +require 'kyanite/enumerable/structure'+

# @!macro [new] class_utils
#  === Class Utils
#  [Kyanite definitions] {Class}, {Symbol}, {String}
#  [Kyanite tests and examples] {TestKyaniteClassutils}    
#  [Usage] +require 'kyanite/general/classutils'+
#

# @!macro [new] hash
#  === Hash Additions
#  [Kyanite definitions] {Dictionary}, {Hash}
#  [Kyanite tests and examples] {TestKyaniteHash}    
#  [Usage] +require 'kyanite/hash'+  
#
# Note: If you define the method +==+ in any object, you have to define +hash+ as well.
#
# Note: Rubys +delete+ and +delete_if+ methods are working in-place, even if the name does not implicate that.
# And they return the deleted value, not the hash.
#

# @!macro [new] numeric
#  === Numeric Additions
#  [Kyanite definitions] {Numeric} {Integer} {Float}
#  [Kyanite tests and examples] {TestKyaniteNumeric} 
#  [Usage] +require 'kyanite/numeric'+
#

# @!macro [new] optimizer
#  === Optimizer 
#  [Kyanite definitions] {Optimizer}
#  [Kyanite tests and examples] {TestKyaniteOptimizer}  
# 
#  Find objects with min or max score.
#  Each object is written to the Optimizer by a +push+ command, together with it's score.
#  +content_max+ and +content_min+ result the object with the highest / lowest score.
#  The access to the second and third objects is possible by deleting objects with 
#  +delete_max+ or +delete_min+.

# @!macro [new] range
#  === Range Additions
#  [Kyanite definitions] {Range}
#  [Kyanite tests and examples] {TestKyaniteRange}    
#  [Usage] +require 'kyanite/range'+

# @!macro [new] set
#  === Set Classes and Additions
#  [Kyanite definitions] {Set}, {SortedSet}, {OrderedSet} 
#  [Kyanite tests and examples] {TestKyaniteSet}  
#  [Usage] +require 'kyanite/set'+
#  === Differences between the set classes
#  [{http://www.ruby-doc.org/stdlib-1.9.3/libdoc/set/rdoc/Set.html +Set+}] is unordered. Examples:  {TestKyaniteSet#test_set test_set}
#  [{OrderedSet}] is ordered, it retains the original order, but it will not continually re-sorted -- as long you don't use {http://rubydoc.info/github/rubyworks/hashery/master/Hashery/Dictionary:order_by +Dictionary#order_by+}. Examples:  {TestKyaniteSet#test_ordered_set test_ordered_set}
#  [{http://www.ruby-doc.org/stdlib-1.9.3/libdoc/set/rdoc/SortedSet.html +SortedSet+}] is ordered and sorted. It is always in order. Examples:  {TestKyaniteSet#test_sorted_set test_sorted_set}
#

# @!macro [new] string
#  === String Additions
#  [Kyanite definitions] {String} 
#  [Kyanite tests and examples] {TestKyaniteStringCast Cast} {TestKyaniteStringChars Chars} {TestKyaniteStringDiff Diff} {TestKyaniteStringList Database-Helper} {TestKyaniteStringMisc Miscellaneous} {TestKyaniteStringNested Nested} {TestKyaniteStringSplit Split}     
#  [Usage] +require 'kyanite/string'+
#  === Required from {http://rubyworks.github.com/rubyfaux/?doc=http://rubyworks.github.com/facets/docs/facets-2.9.3/core.json#api-class-String Facets String}:  
#  [+shatter(re)+] Breaks a string up into an array based on a regular expression. Similar to scan, but includes the matches.
#


# @!macro [new] tree
#  === Rubytree Additions
#  [Kyanite definitions] {Tree::TreeNode}
#  [Kyanite tests and examples] {TestKyaniteTree}    
#  [Base class] {http://rubytree.rubyforge.org +rubytree+}
#  [Usage] +require 'kyanite/tree'+  

# @!macro [new] object
#  === Object Additions
#  [Kyanite definitions] {Object}, {KKernel}
#  [Kyanite tests and examples] {TestKyaniteObject}    
#  [Usage] +require 'kyanite/basics'+  

# @!macro [new] undoable 
#  === Undoable Module
#  Save and restore objects. Great for try-and-error-algorithms.
#  [Kyanite definitions] {Undoable}
#  [Kyanite tests and examples]    
#  [Usage] +require 'kyanite/general/undoable'+  

# @!macro [new] true_false
#  === TrueClass & FalseClass
#  [Kyanite definitions] {TrueClass} {FalseClass}
#  [Kyanite tests and examples] {TestKyaniteTrueFalse}    
#  [Usage] +require 'kyanite/general/true_false'+ 

# @!macro [new] caller_utils
#  === CallerUtils
#  [Kyanite definitions] {CallerUtils} 
#  [Kyanite tests and examples]  
#  [Usage] +require 'kyanite/general/callerutils'+ 

  require 'drumherum'

  require 'kyanite/array'
# require 'kyanite/basics'            # Auswahl
  require 'kyanite/dictionary'
  require 'kyanite/enumerable'       
  require 'kyanite/general'
  require 'kyanite/hash'
  require 'kyanite/numeric' 
  require 'kyanite/optimizer'
  require 'kyanite/range'
  require 'kyanite/set'
  require 'kyanite/string'
  require 'kyanite/symbol'
  require 'kyanite/tree'
# require 'kyanite/unit_test'         # nur für Tests

  Drumherum::loaded!

