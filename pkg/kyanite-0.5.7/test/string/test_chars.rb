# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require File.join(File.dirname(__FILE__), '..', '..', 'smart_load_path.rb' )
  smart_load_path   
end

require 'kyanite/unit_test'
require 'kyanite/string/chars'                                  
                             



# Tests for String
#
class TestKyaniteStringChars < UnitTest

# ---------------------------------------------------------------------------------------------------------------------------------
# :section: clear / format text
#     


    
  def test_reduce94_a
    full    = 'àáâăäãāåạąæảấầắằÀÁÂĂÄÃĀÅẠĄÆẢẤẦẮẰ'
    reduced = 'aaaaaaaaaaaaaaaaAAAAAAAAAAAAAAAA'   
    assert_equal reduced,       full.reduce94  
  end
  
  def test_reduce94_b
    full    = 'ćĉčçċĆĈČÇĊďðđĎÐĐèéêěĕëēėęếÈÉÊĚĔËĒĖĘẾ'
    reduced = 'cccccCCCCCdddDDDeeeeeeeeeeEEEEEEEEEE'   
    assert_equal reduced,       full.reduce94  
  end  
  
  def test_reduce94_c
    full    = 'ĝğġģĜĞĠĢĥħĤĦìíîĭïĩīıįĳÌÍÎĬÏĨĪİĮĲĵĴķĸĶĺľłļŀĹĽŁĻĿ'
    reduced = 'ggggGGGGhhHHiiiiiiiiiiIIIIIIIIIIjJkkKlllllLLLLL'   
    assert_equal reduced,       full.reduce94  
  end    
  
  def test_reduce94_e
    full    = 'ńňñņŉŋŃŇÑŅŊòóôŏöõōøőơœÒÓÔŎÖÕŌØŐƠŒ'
    reduced = 'nnnnnnNNNNNoooooooooooOOOOOOOOOOO'   
    assert_equal reduced,       full.reduce94  
  end      
  
  def test_reduce94_f
    full    = 'ŕřŗŔŘŖśŝšßşŚŜŠŞţťŧþŢŤŦÞùúûŭüũūůűųưÙÚÛŬÜŨŪŮŰŲƯŵŴýŷÿÝŶŸźżžŹŻŽ'
    reduced = 'rrrRRRsssssSSSSttttTTTTuuuuuuuuuuuUUUUUUUUUUUwWyyyYYYzzzZZZ'   
    assert_equal reduced,       full.reduce94  
  end    
  

  
  
  def test_reduce94_full
    full = <<ENDOFSTRING
àáâăäãāåạąæảấầắằÀÁÂĂÄÃĀÅẠĄÆẢẤẦẮẰćĉčçċĆĈČÇĊďðđĎÐĐèéêěĕëēėęếÈÉÊĚĔËĒĖĘẾĝğġģĜĞĠĢĥħĤĦìíîĭïĩīıįĳÌÍÎĬÏĨĪİĮĲĵĴķĶĺľłļŀĹĽŁĻĿńňñņŉŋŃŇÑŅŊòóôŏöõōøőơœÒÓÔŎÖÕŌØŐƠŒŕřŗŔŘŖśŝšßşŚŜŠŞţťŧþŢŤŦÞùúûŭüũūůűųưÙÚÛŬÜŨŪŮŰŲƯŵŴýŷÿÝŶŸźżžŹŻŽ
ENDOFSTRING

    reduced = <<ENDOFSTRING
aaaaaaaaaaaaaaaaAAAAAAAAAAAAAAAAcccccCCCCCdddDDDeeeeeeeeeeEEEEEEEEEEggggGGGGhhHHiiiiiiiiiiIIIIIIIIIIjJkKlllllLLLLLnnnnnnNNNNNoooooooooooOOOOOOOOOOOrrrRRRsssssSSSSttttTTTTuuuuuuuuuuuUUUUUUUUUUUwWyyyYYYzzzZZZ
ENDOFSTRING

    full = full.chomp
    reduced = reduced.chomp
    
    assert_equal reduced,       full.reduce94      
    
    # require 'perception'
    # rawlog "\n----------------------------------------------------------\n\n"
    # rawlog 'full=     '
    # rawlog full
    # rawlog "\n"
    # rawlog 'reduced=  '
    # rawlog reduced
    # rawlog "\n"  
  end
  
  
  def test_reduce53_a
    full    = '   ŕřŗŔŘŖśŝšßşŚŜ    ŠŞţťŧþŢŤŦÞùúûŭ   üũūůűųưÙÚÛ    ÜŨŪŮŰŲƯŵ   ŴýŷÿÝŶŸźżžŹŻŽ  '
    reduced = 'rrrrrrsssssss-ssttttttttuuuu-uuuuuuuuuu-uuuuuuuw-wyyyyyyzzzzzz'   
    assert_equal reduced,       full.reduce53 
  end     
  
  def test_reduce53_b
    full    = "   h A-- $%$%--llo §-$\n$^°  "
    reduced = 'H-A-LLO'   
    assert_equal reduced,       full.reduce53 
  end   
  
  def test_reduce53_c
    full    = "   h A-- $%Ѥ%--llo\n §-$\n$^°  "
    reduced = 'H-A-LLO'   
    assert_equal reduced,       full.reduce53 
  end    
  
  def test_reduce53_d
    full    = "   h Ä-- $%Ѥ%--llo\n §-$\n$^°  "
    reduced = 'H-a-LLO'   
    assert_equal reduced,       full.reduce53 
  end      
  
  def test_reduce53_e
    full    = "   h ä-- $%Ѥ%--llo\n §-$\n$^°  "
    reduced = 'H-a-LLO'   
    assert_equal reduced,       full.reduce53 
  end     

  
  def test_german_sz
    assert_equal 'SCHEIßE',   'Scheiße'.upcase2
    assert_equal 'SCHEIßE',   'scheiße'.upcase2
    assert_equal 'scheiße',   'Scheiße'.downcase2    
    assert_equal 'scheiße',   'SCHEIßE'.downcase2
    assert_equal 'Scheise',   'Scheiße'.reduce94
    assert_equal 'SCHEIsE',   'Scheiße'.reduce53
    assert_equal 'SCHEIZE',   'Scheiße'.reduce53(:german_sz => 'z')
    assert_equal 'SCHEIZE',   'Scheiße'.reduce53(:german_sz => 'Z')
    assert_equal 'SCHEISSE',  'Scheiße'.reduce53(:german_sz => 'SS')
    
    # geht vielleicht in Ruby 1.9
    assert_equal 'Scheize',   'Scheiße'.reduce94(:german_sz => 'z')
    assert_equal 'ScheiZe',   'Scheiße'.reduce94(:german_sz => 'Z')
    assert_equal 'Scheisse',  'Scheiße'.reduce94(:german_sz => 'ss')    
    assert_equal 'Schei$e',   'Scheiße'.reduce94(:german_sz => '$')      
    assert_equal 'Schei$e',   'Schei$e'.reduce94    
  end  
  
  
  def test_camelcase
    assert_equal 'TUKTUK',    'TukTuk'.reduce53
    assert_equal 'TUKTUK',    'TukTuk'.reduce53(:camelcase => false)
    assert_equal 'TUK-TUK',   'TukTuk'.reduce53(:camelcase => true)
    assert_equal 'TUK-TUK',   'tukTuk'.reduce53(:camelcase => true)
  end    
  
  
  
  # def test_mysqlize
    # test0 = 'aaoouuß'  
    # test1 = 'aäoöuüss'
    # test2 = 'AÄOÖUÜSS'
    # test3 = 'AAOOUUß'   
  
    # assert_equal test0,   test0.mysqlize
    # assert_equal test0,   test1.mysqlize
    # assert_equal test0,   test2.mysqlize
    # assert_equal test0,   test3.mysqlize
  # end   
  
  

  
  
# ---------------------------------------------------------------------------------------------------------------------------------
# :section: Groß- und Kleinschreibung
#     

  
  def test_downcase_upcase
    test_down =       'àáâăäãāåạąæảấầắằабćĉčçċцчďðđдèéêěĕëēėęếеэфĝğġģгĥħхìíîĭïĩīıįĳийĵюяķкĺľłļŀлмńňñņŋнòóôŏöõōøőơœопŕřŗрśŝšşсшщţťŧþтùúûŭüũūůűųưувŵýŷÿźżžжз'
    test_up =         'ÀÁÂĂÄÃĀÅẠĄÆẢẤẦẮẰАБĆĈČÇĊЦЧĎÐĐДÈÉÊĚĔËĒĖĘẾЕЭФĜĞĠĢГĤĦХÌÍÎĬÏĨĪİĮĲИЙĴЮЯĶКĹĽŁĻĿЛМŃŇÑŅŊНÒÓÔŎÖÕŌØŐƠŒОПŔŘŖРŚŜŠŞСШЩŢŤŦÞТÙÚÛŬÜŨŪŮŰŲƯУВŴÝŶŸŹŻŽЖЗ'

    # Bescheid sagen, sobald Ruby oder ActiveSupport von sich aus funktionieren
    assert_not_equal test_down,       test_up.downcase
    assert_not_equal test_down,       test_up.downcase
        
    assert_equal test_down,           test_up.downcase2
    assert_equal test_down,           test_up.upcase2.downcase2
    assert_equal test_down,           test_up.upcase2.downcase2.upcase2.downcase2
    
    assert_equal test_up,             test_down.upcase2
    assert_equal test_up,             test_down.downcase2.upcase2
    assert_equal test_up,             test_down.downcase2.upcase2.downcase2.upcase2     
    
    teststrings = ['ÄÖÜ', 'äöü','ÄÖÜß', 'äöüß',]
    teststrings.each do |t|
      assert_equal t.upcase2,         t.downcase2.upcase2
      assert_equal t.downcase2,       t.upcase2.downcase2
    end
    
    assert_equal 'ÄÖÜ',     'äöü'.upcase2
    assert_equal 'ÄÖÜ',     'äöü'.upcase2.upcase2
    assert_equal 'ÄÖÜß',    'äöüß'.upcase2.upcase2
    assert_equal 'äöü',     'ÄÖÜ'.downcase2
    assert_equal 'äöü',     'ÄÖÜ'.downcase2.downcase2
    assert_equal 'äöüß',    'ÄÖÜß'.downcase2.downcase2    
  end
  
  
  def test_capitalized?
    assert !'hallo'.capitalized?
    assert !'ħAllo'.capitalized?
    assert !'ĥÅllo'.capitalized?
    assert !'ätsch'.capitalized?    
    
    assert 'Hallo'.capitalized?    
    assert 'ĤAllo'.capitalized?
    assert 'ĦAllo'.capitalized?
    assert 'Ætsch Ruby scheißt auf Unicode'.capitalized?
    assert 'Ūbel'.capitalized?
    assert 'Øzi ist moderner'.capitalized?
  end
  
  
  def test_capitalize
    test_down =       'äaoöuü'
    test_up =         'ÄAOÖUÜ'  
    
    assert_equal  'Äaoöuü',   'äaoöuü'.capitalize 
    assert_equal  'Àaoöuü',   'àaoöuü'.capitalize 
    assert_equal  'Ăăaoöuü',  'ăăaoöuü'.capitalize 
    assert_equal  'Öaoöuü',   'Öaoöuü'.capitalize
  end  
  
  
  def test_utf8_size
    assert_equal 3, 'Özi'.size   
  end     
  
  
  


  
    
    
end # class

































