# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
end
require 'drumherum/unit_test'
require 'transparent_nil'    unless defined? TransparentNil   
require 'kyanite/set'   
                 

                 
# @!group Set

# @!macro set
class TestKyaniteSet < UnitTest

  
  # ungeordnet
  def test_set
    array = [1,2,7,1,1,5,2,5,1]
    assert_equal [1,2,7,5],                     array.uniq              # uniq
    assert_equal array.to_set,                  [1,2,7,5].to_set        # to-set macht auch ein uniq
    assert_equal [5,7,2,1].to_set,              [1,2,7,5].to_set        # Sets sind ungeordnet
  end 
  
  
  # behält die Reihenfolge
  def test_ordered_set
    # assert ([5,2,7,1].to_ordered_set != [1,2,7,5].to_ordered_set) 
    assert_equal [1,2,7,5],                                   [1,2,7,1,1,5,2,5,1].to_ordered_set.to_a 
    assert_equal [5,2,7,1],                                   [5,2,7,1,1,5,2,5,1].to_ordered_set.to_a 
    
    test = [5,:a,7,1,1,5,:a,5,1].to_ordered_set
    assert_equal 5,  test[0]
    assert_equal :a, test[1]
    assert_equal 1,  test[-1]
  end   
  
  
  # sortiert
  def test_sorted_set
    assert_equal [1,2,5,7],                                   [1,2,7,1,1,5,2,5,1].to_sorted_set.to_a 
    assert_equal [1,2,5,7],                                   [5,2,7,1,1,5,2,5,1].to_sorted_set.to_a 
  end   
  
  
  def test_equal
    assert_equal ['Set'].to_set,                        ['Set'].to_set
    assert_equal [:a, :b].to_set,                       [:a, :b].to_set    
    assert_equal [:b, :a].to_set,                       [:a, :b].to_set    
    
    # Erfordert die Korrektur der Methoden hash und eql? in der Klasse Hash
    assert_equal [[:a].to_set, [:b].to_set].to_set,     [[:a].to_set, [:b].to_set].to_set
    assert_equal [[:b].to_set, [:a].to_set].to_set,     [[:a].to_set, [:b].to_set].to_set
    
    assert_equal ['OrderedSet'].to_ordered_set,         ['OrderedSet'].to_ordered_set
    assert_equal [:a, :b].to_ordered_set,               [:a, :b].to_ordered_set
    assert_equal [:b, :a].to_ordered_set,               [:a, :b].to_ordered_set
      
    assert_equal ['SortedSet'].to_sorted_set,           ['SortedSet'].to_sorted_set   
    assert_equal [:a, :b].to_sorted_set,                [:a, :b].to_sorted_set         
    assert_equal [:b, :a].to_sorted_set,                [:a, :b].to_sorted_set         
  end
  
  
  def test_hash
    s = Set.new
    s << {:user_id => 1, :private => false}
    assert_equal 1, s.size
    s << {:user_id => 1, :private => false}
    assert_equal 1, s.size
  end
  
  
  
  def test_index
    test = [:d, :c, :b, :a].to_ordered_set
    assert_equal 0,   test.index(:d)
    assert_equal 3,   test.index(:a)
  end
  
  
  def test_is_collection
    assert [1].to_set.is_collection?
    assert [1].to_sorted_set.is_collection?
    assert [1].to_ordered_set.is_collection?
  end
  
  
  def test_each
    test = [:d, :c, :b, :a].to_set
    result = []
    test.each do |e| 
      result << e
    end
    assert_equal [:a, :b, :c, :d],   result.sort
    
    test = [:d, :c, :b, :a].to_sorted_set
    result = []
    test.each do |e| 
      result << e
    end
    assert_equal [:a, :b, :c, :d],   result    
    
    test = [:d, :c, :b, :a].to_ordered_set
    result = []
    test.each do |e| 
      result << e
    end
    assert_equal [:d, :c, :b, :a],   result      
  end
  
     
  
  # def test_to_set_of_sets
    # expected = Set.new([
    # Set.new([:eins]), 
    # Set.new([:zwei]), 
    # Set.new([:drei]), 
    # ])
    # assert_equal expected,      [:eins, :zwei, :drei].to_set_of_sets
    # assert_equal expected,      [:zwei, :eins, :drei].to_set_of_sets
    # assert_equal SetOfSets,     [:zwei, :eins, :drei].to_set_of_sets.class
    
    # assert_equal expected,    [[:zwei], [:eins], [:drei]].to_set_of_sets
    
    # expected = [[:c], [:eins, :zwei], [:a, :b], [:drei]].to_set_of_sets
    # assert_equal expected,  [[:eins, :zwei], :drei].to_set_of_sets + [[:a, :b], :c].to_set_of_sets
  # end
  
  
  def test_equal_2
    print 'x'
    #return
  
    a = [ 'Liam', 'Lolomai', 'Ljubow', 'Luise', 'Livian', 'Levin', 'Lian', 'Leana', 'Lorita', 'Lady', 'Leslie', 'Lena', 'Lensi', 'Livio', 'Lorraine', 
          'Liana', 'Linus', 'Lennet', 'Lorna', 'Levi', 'Leonie', 'Linna', 'Lucill', 'Luk', 'Léan', 'Laurence', 'Laurin', 'Lucia', 'Lúthien', 
          'László', 'Leonharda', 'Liane', 'Lene', 'Lambert', 'Lukas', 'Lothar', 'Lykka', 'Lissy', 'Lilian', 'Lina', 'Liv', 'Laura', 'Levent', 
          'Lotta', 'Lysander', 'Lientje', 'Lynn', 'Lea', 'Lucie', 'Laurens', 'Lance', 'Lionel', 'Leonore', 'Leni', 'Larry', 'Lale', 'Laurent', 
          'Leontine', 'Lara', 'Larissa', 'Lamprecht', 'Leandro', 'Leyla', 'Ljilja', 'Line', 'Liz', 'Lloyd', 'Lotte', 'Ludwig', 'Lodewijk', 'Leonhard', 
          'Laurentius', 'Lenn', 'Leticia', 'Lioba', 'Leif', 'Louis', 'Lieselotte', 'Lenelies', 'Lennart', 'Levke', 'Lizzy', 'Luis', 'Lorenz', 'Lei',
          'Laurenz', 'Levente', 'Lucius', 'Louisa', 'Lorcan', 'Lucy', 'Lutz', 'Liria',  'Ludmilla', 'Lilli', 'Lewin', 'Luciano', 'Linn', 'Laetitia', 
          'Liselotte', 'Lasse', 'Louise', 'Laje', 'Len', 'Linda', 'Lieven', 'Luitgard', 'Lais', 'Lisanne', 'Lunis', 'Leo', 'Laijana', 'Lyn', 'Leolas', 
          'Leona', 'Laatvik', 'Latif', 'Luka', 'Lutricia', 'Lia', 'Leonard', 'Larina', 'Livia', 'Leiderat', 'Lukaja', 'Ljudmila', 'Leila', 'Lienhard',
          'Lenja', 'Ljubiša', 'Lilith', 'Lennox', 'Luna', 'Lenio', 'Leah', 'Lydia', 'Ljiljana', 'Lili', 'Lauritz', 'Liska', 'Lola', 'Lenny', 'Lenore', 
          'Lorena', 'Leilani', 'Leon', 'Lacey', 'Luke', 'Lars', 'Lev', 'Ludger', 'Laila', 'Loris', 'Lakambini', 'Lidwina', 'Laurentia', 'Larees', 
          'Luana', 'Leoni', 'Loreley', 'Lucas', 'Luca', 'Langer', 'Liah', 'Leander', 'Letizia', 'Luc', 'Lana', 'Laurie', 'Linnea', 'Lajos', 
          'Lidia', 'Luisa', 'Lilo', 'Lenya', 'Lion', 'Luigi', 'Leandra', 'Linya', 'Lenius', 'Lisa', 'Leonardo', 'Lore', 'Laureen', 'Lilly', 'Lennard']
    
    b = [ 'Liam', 'Lolomai', 'Livian', 'Levin', 'Lian', 'Luise', 'Ljubow', 'Leana', 'Lorita', 'Lena', 'Lensi', 'Livio', 'Lorraine', 'Liana', 'Linus', 
          'Lady', 'Leslie', 'Lennet', 'Lorna', 'Levi', 'Leonie', 'Linna', 'Léan', 'Lucill', 'Laurence', 'Luk', 'Laurin', 'Leonharda', 'Liane', 
          'László', 'Lucia', 'Lúthien', 'Lene', 'Lukas', 'Lambert', 'Lissy', 'Lykka', 'Lothar', 'Lilian', 'Liv', 'Lina', 'Laura', 'Lientje', 'Lotta', 
          'Lynn', 'Levent', 'Lea', 'Lysander', 'Laurens', 'Lance', 'Lucie', 'Lionel', 'Leonore', 'Leni', 'Larry', 'Lale', 'Laurent', 'Leontine', 'Lara', 
          'Larissa', 'Leandro', 'Leyla', 'Lamprecht', 'Ljilja', 'Liz', 'Line', 'Ludwig', 'Lloyd', 'Lotte', 'Leonhard', 'Laurentius', 'Lenn', 'Lodewijk',
          'Leif', 'Lieselotte', 'Louis', 'Lenelies', 'Lioba', 'Leticia', 'Lennart', 'Lizzy', 'Lorenz', 'Lei', 'Luis', 'Levke', 'Laurenz', 'Lorcan', 
          'Lucius', 'Levente', 'Louisa', 'Lutz', 'Liria', 'Lucy', 'Lilli', 'Ludmilla', 'Lewin', 'Linn', 'Luciano', 'Laje', 'Laetitia', 'Len', 
          'Louise', 'Lasse', 'Liselotte', 'Linda', 'Leona', 'Lieven', 'Lunis', 'Lisanne', 'Leo', 'Laijana', 'Luitgard', 'Lais', 'Lyn', 'Leolas', 
          'Larina', 'Leonard', 'Lia', 'Lutricia', 'Luka', 'Latif', 'Laatvik', 'Lenja', 'Lienhard', 'Leila', 'Ljudmila', 'Lukaja', 'Leiderat', 
          'Livia', 'Leah', 'Lenio', 'Luna', 'Lennox', 'Lilith', 'Ljubiša', 'Lauritz', 'Lili', 'Ljiljana', 'Lydia', 'Leon', 'Leilani', 'Lorena', 
          'Lenore', 'Lenny', 'Lola', 'Liska', 'Lars', 'Luke', 'Lacey', 'Loris', 'Laila', 'Ludger', 'Lev', 'Loreley', 'Leoni', 'Luana', 'Larees', 
          'Laurentia', 'Lidwina', 'Lakambini', 'Leander', 'Liah', 'Langer', 'Luca', 'Lucas', 'Lajos', 'Linnea', 'Laurie', 'Lana', 'Luc', 
          'Letizia', 'Lion', 'Lenya', 'Lilo', 'Luisa', 'Lidia', 'Lenius', 'Linya', 'Leandra', 'Luigi', 'Lennard', 'Lilly', 'Laureen',
          'Lore', 'Leonardo', 'Lisa']

    assert_equal      a.sort,         b.sort
    assert_equal      a.sort.hash,    b.sort.hash
    assert_equal      a.to_set,       b.to_set
    
    c = Set.new
    c << a.to_set
    c << b.to_set
    assert_equal 1,   c.size      
    
    #ap c    
    
    
    #assert_equal 2,   c.size      
    
    # puts
    # c.each do |e|
      # ap e.hash
    # end
   


    
  end
  
  
  


  

  

end # class 

















