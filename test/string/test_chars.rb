# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
  require 'perception'
end
require 'drumherum/unit_test'
require 'kyanite/string/chars'                                  
                             



# Tests for String
# @!macro string
class TestKyaniteStringChars < UnitTest

# ---------------------------------------------------------------------------------------------------------------------------------
# @!group clear / format text
#     

  def test_TR_EXTRA_CHARS
    startline = 23 # Zeilennummer in der TR_EXTRA_CHARS definiert wird
    i = 0
    all = ""
    TR_EXTRA_CHARS.each do | a |
      c = a[0].to_s[7]
      all += c
      assert_equal 0, all.to_a.to_set.size-i-1, "TR_EXTRA_CHARS: Dup in Zeile #{i+startline} Zeichen #{c}"  
      #assert c.to_array_of_codepoints[0] > 127, "TR_EXTRA_CHARS: Trivialität in Zeile #{i+startline} Zeichen #{c}"   
      i+=1
    end
  end
  
  
  def test_TR_FULL
    assert_equal TR_FULL.length, TR_REDUCED.length
    i = 0
    all = ""
    TR_FULL.each_char do | c |
      r = TR_REDUCED[i]    
      all += c
      #see "Zeichen Nr. #{i} Zeichen #{c} >> #{r}"      
      assert_equal 0, all.to_a.to_set.size-i-1, "TR_FULL: Dup in Zeichen Nr. #{i} Zeichen #{c} >> #{r}"  
      assert c.to_array_of_codepoints[0] > 127, "TR_FULL: Trivialität in Zeichen Nr. #{i} Zeichen #{c} >> #{r}"  
      assert r.to_array_of_codepoints[0] <= 127, "TR_FULL: Zeichen Nr. #{i} Zeichen #{c} >> #{r} wird nicht in ASCII umgesetzt"        
      assert_equal c.reduce94, c.to_ascii[0]     
      i+=1
    end
  end  
  
  
  def test_TR_FULL_TO_ASCII
    assert_equal TR_FULL_TO_ASCII.length, TR_REDUCED_TO_ASCII.length
    i = 0
    all = ""
    TR_FULL_TO_ASCII.each_char do | c |
      r = TR_REDUCED_TO_ASCII[i]
      all += c
      #see "Zeichen Nr. #{i} Zeichen #{c} >> #{r}" 
      assert_equal 0, all.to_a.to_set.size-i-1,          "TR_FULL_TO_ASCII: Dup in Zeichen Nr. #{i} Zeichen #{c} >> #{r}"  
      assert c.to_array_of_codepoints[0] > 127,  "TR_FULL_TO_ASCII: Trivialität in Zeichen Nr. #{i} Zeichen #{c} >> #{r}"   
      assert r.to_array_of_codepoints[0] <= 127, "TR_FULL_TO_ASCII: Zeichen Nr. #{i} Zeichen #{c} >> #{r} wird nicht in ASCII umgesetzt"        
      i+=1
    end
  end    
   

  def test_to_array_of_codepoints
    test = "H¿llÛ"
    assert_equal [72, 191, 108, 108, 219],    test.to_array_of_codepoints
    assert_equal test,                        [72, 191, 108, 108, 219].to_s_utf8
  end
  
  def test_to_array_of_hex
    euro = "\u20ac"
    ffi = "\uFB03"
    ix = "\u2168"
    high5 = "\u2075"
    all = euro + ffi + ix + high5
    assert_equal ["20ac", "fb03", "2168", "2075"], all.to_array_of_hex
  end
  

    
  def test_to_ascii_a
    full    = 'ªàáâăãāåạąảấầắằÀÁÂĂÃĀÅẠĄẢẤẦẮẰ'
    reduced = 'aaaaaaaaaaaaaaaAAAAAAAAAAAAAA' 
    assert_equal reduced,       full.reduce94      
    assert_equal reduced,       full.to_ascii      
  end
  
  def test_to_ascii_b
    full    =   'ćĉčçċĆĈČÇĊďĎèéêěĕëēėęếÈÉÊĚĔËĒĖĘẾ'
    reduced1 =  'cccccCCCCCdDeeeeeeeeeeEEEEEEEEEE'  
    reduced2 =  'ccccchCCCCChdDeeeeeeeeeeEEEEEEEEEE'
    assert_equal reduced1,       full.reduce94  
    assert_equal reduced2,       full.to_ascii  
  end  
  
  def test_to_ascii_c
    full    =   'ĝğġģĜĞĠĢĥĤìíîĭïĩīįÌÍÎĬÏĨĪİĮĵĴķĶĺľļŀĹĽĻĿ'
    reduced1 =  'ggggGGGGhHiiiiiiiiIIIIIIIIIjJkKllllLLLL'  
    reduced2 =  'ggghgGGGhGhHiiiiiiiiIIIIIIIIIjJkKllllLLLL'
    assert_equal reduced1,       full.reduce94  
    assert_equal reduced2,       full.to_ascii      
  end    
  
  def test_to_ascii_e
    full    = 'ńňñņŉŃŇÑŅòóôŏõōőơÒÓÔŎÕŌŐƠ'
    reduced = 'nnnnnNNNNooooooooOOOOOOOO' 
    assert_equal reduced,       full.reduce94  
    assert_equal reduced,       full.to_ascii      
  end      
  
  def test_to_ascii_f
    full    =   'ŕřŗŔŘŖśŝšşŚŜŠŞţťŢŤùúûŭũūůűųưÙÚÛŬŨŪŮŰŲƯŵŴýŷÿÝŶŸźżžŹŻŽ'
    reduced1 =  'rrrRRRssssSSSSttTTuuuuuuuuuuUUUUUUUUUUwWyyyYYYzzzZZZ'  
    reduced2 =  'rrrRRRssshsSSShSttTTuuuuuuuuuuUUUUUUUUUUwWyyyYYYzzzhZZZh' 
    assert_equal reduced1,       full.reduce94  
    assert_equal reduced2,       full.to_ascii      
  end    
  
  def test_to_ascii_zusammengesetzt
    full    = 'ĳĲſ…'
    reduced = 'ijIJs...'  
    assert_equal reduced,       full.to_ascii      
  end    
  
  def test_to_ascii_same_same
    same_same    = '^!"$%&/()=?@*+~#<>|,;:.-_ {[]}\\'
    assert_equal same_same,     same_same.to_ascii 
    same_same    = "'0123456789"
    assert_equal same_same,     same_same.to_ascii  
    same_same    = 'abcdefghijklmnopqrstuvwxyz'
    assert_equal same_same,     same_same.to_ascii  
    same_same    = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    assert_equal same_same,     same_same.to_ascii     
  end
  
  
  def test_to_ascii_same_same
    full = '¯¨'
    reduced = ' ' * full.length
    assert_equal 2,             full.length
    assert_equal reduced,       full.to_ascii    
  end
  
  def test_to_ascii_s
    ffi = "\uFB03"
    ix = "\u2168"
    high23="²³"
    high5 = "\u2075"
    full = ffi + ix + high23 + high5 + "€ßÖÜÄöüä"
    reduced1 = "sOUAoua"
    reduced2 = "ffiIX235EURssOeUeAeoeueae"
    assert_equal reduced1,       full.reduce94      
    assert_equal reduced2,       full.to_ascii      
  end
  
  def test_LANG_SPECIAL_CHARS
    LANG_SPECIAL_CHARS .each do | lang, (full, reduced) |
      #see lang, full, reduced, full.to_ascii, full.reduce94
      assert_equal reduced,       full.to_ascii       
    end  
  end
  
  def test_spaces
    spaces =  "\u0020\u00a0\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u202f\u205f\u3000\u2420\u2423"
    assert_equal spaces.to_ascii, " " * spaces.length
    assert_equal spaces.reduce94, " " * spaces.length
  end
  
  
  def test_minus_signs
    minus = "\u00ac\u2212\u2010\u2011\u2012\u2013\u2014\u2015\u2500"
    assert_equal minus.to_ascii, "-" * minus.length
    #assert_equal spaces.reduce94, " " * spaces.length    
  end
  

  
  
  def test_reduce94_full
    full = <<ENDOFSTRING
àáâăäãāåạąảấầắằÀÁÂĂÄÃĀÅẠĄẢẤẦẮẰćĉčçċĆĈČÇĊďðđĎÐĐèéêěĕëēėęếÈÉÊĚĔËĒĖĘẾĝğġģĜĞĠĢĥħĤĦìíîĭïĩīıįÌÍÎĬÏĨĪİĮĵĴķĶĺľłļŀĹĽŁĻĿńňñņŉŋŃŇÑŅŊòóôŏöõōøőơœÒÓÔŎÖÕŌØŐƠŒŕřŗŔŘŖśŝšßşŚŜŠŞţťŧþŢŤŦÞùúûŭüũūůűųưÙÚÛŬÜŨŪŮŰŲƯŵŴýŷÿÝŶŸźżžŹŻŽ
ENDOFSTRING

    reduced = <<ENDOFSTRING
aaaaaaaaaaaaaaaAAAAAAAAAAAAAAAcccccCCCCCdddDDDeeeeeeeeeeEEEEEEEEEEggggGGGGhhHHiiiiiiiiiIIIIIIIIIjJkKlllllLLLLLnnnnnnNNNNNoooooooooooOOOOOOOOOOOrrrRRRsssssSSSSttttTTTTuuuuuuuuuuuUUUUUUUUUUUwWyyyYYYzzzZZZ
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
  
  
  
  def test_mysqlize
    test0 = 'aaoouuß'  
    test1 = 'aäoöuüss'
    test2 = 'AÄOÖUÜSS'
    test3 = 'AAOOUUß'   
  
    assert_equal test0,   test0.mysqlize
    assert_equal test0,   test1.mysqlize
    assert_equal test0,   test2.mysqlize
    assert_equal test0,   test3.mysqlize
  end   
  
  

  
  
# ---------------------------------------------------------------------------------------------------------------------------------
# @!group Groß- und Kleinschreibung
#     

  
  def test_downcase_upcase
    test_down =       'àáâăäãāåạąảấầắằабćĉčçċцчďðđдèéêěĕëēėęếеэфĝğġģгĥħхìíîĭïĩīıįийĵюяķкĺľłļŀлмńňñņŋнòóôŏöõōøőơœопŕřŗрśŝšşсшщţťŧþтùúûŭüũūůűųưувŵýŷÿźżžжз'
    test_up =         'ÀÁÂĂÄÃĀÅẠĄẢẤẦẮẰАБĆĈČÇĊЦЧĎÐĐДÈÉÊĚĔËĒĖĘẾЕЭФĜĞĠĢГĤĦХÌÍÎĬÏĨĪİĮИЙĴЮЯĶКĹĽŁĻĿЛМŃŇÑŅŊНÒÓÔŎÖÕŌØŐƠŒОПŔŘŖРŚŜŠŞСШЩŢŤŦÞТÙÚÛŬÜŨŪŮŰŲƯУВŴÝŶŸŹŻŽЖЗ'

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

































