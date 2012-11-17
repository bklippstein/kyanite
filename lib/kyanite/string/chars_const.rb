# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init
  require 'perception'  
end

require 'hashery' 
require 'unicode_utils/char_type'


unless defined?(TR_UPCASE_ALL_REGEXP)

  leerzeichen = "\u2420\u2423\u00a0\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u202f\u205f\u3000"
  klammer_auf = "\u227a\u226a\u3008\u276c\u2329\u25c1\u25c0"
  klammer_zu =  "\u227b\u226b\u3009\u276d\u232a\u25b7\u25b6"

  # Sowohl reduce94 als auch to_ascii werden diese Zeichen übersetzen.
  # Zeichen, die TR_FULL ergänzen und die UnicodeUtils.nfkd nicht korrekt umsetzt.
  tr_full_b =    %q{£₤¢‹¥›•«×»÷‚‘ƒ’ˆ§´¡„¿“¦”†‡µ′″°¤∗·⋅} + leerzeichen + klammer_auf + klammer_zu
  tr_reduced_b = %q{LLc"Y"*"*"/''f'^P'!"?"|"~~u'"~~***} + (" "*leerzeichen.length) + ("<"*klammer_auf.length) + (">"*klammer_zu.length) 

  # Nur to_ascii wird diese Zeichen übersetzen.
  # Zeichen, die in TR_FULL schon drin sind und die UnicodeUtils.nfkd nicht korrekt umsetzt
  tr_full_c =    %q{ØøðđÐĐħĦıĸłŁŧþŦÞаАбБцчЦЧдДеэЕЭфФгГхХийИЙюяЮЯкКлЛмМнНоОпПрРсшщСШЩтТуУвВжзЖЗ} 
  tr_reduced_c = %q{OoddDDhHiklLttTTaAbBccCCdDeeEEfFgGhHiiIIjjJJkKlLmMnNoOpPrRsssSSStTuUvVzzZZ}

  

  
  # Nur to_ascii wird diese Zeichen übersetzen.  
  TR_EXTRA_CHARS = [
  [/ß/, 'ss'],  
  [/Ö/, 'Oe'],  
  [/Ü/, 'Ue'],  
  [/Ä/, 'Ae'],  
  [/ö/, 'oe'],  
  [/ü/, 'ue'],  
  [/ä/, 'ae'],  
  [/€/, 'EUR'], 
  [/æ/, 'ae'], 
  [/Æ/, 'AE'],
  [/œ/, 'oe'],
  [/Œ/, 'OE'],
  [/ŋ/, 'nj'],
  [/Ŋ/, 'NJ'],
  [/Š/, 'Sh'],
  [/š/, 'sh'],
  [/Ž/, 'Zh'],
  [/ž/, 'zh'],
  [/Ḃ/, 'Bh'],
  [/ḃ/, 'bh'],
  [/Ċ/, 'Ch'],
  [/ċ/, 'ch'],
  [/Ḋ/, 'Dh'],
  [/ḋ/, 'dh'],
  [/Ḟ/, 'Fh'],
  [/ḟ/, 'fh'],
  [/Ġ/, 'Gh'],
  [/ġ/, 'gh'],
  [/Ṁ/, 'Mh'],
  [/ṁ/, 'mh'],
  [/Ṡ/, 'Sh'],
  [/ṡ/, 'sh'],
  [/Ṫ/, 'Th'],
  [/ṫ/, 'th'],
  [/©/, '(c)'],
  [/®/, '(r)'],
  [/≤/, '<='],
  [/≥/, '>='],
  [/±/, '+/-'],
  [/¼/, '1/4'],
  [/½/, '1/2'],
  [/¾/, '3/4'],
  [/‰/, '%%'],
  [/˜/, '~'],
  [/[¬−‐‑‒–—―─]/, '-'] # macht Ärger und muss am Ende bleiben
  ]
  patterns = TR_EXTRA_CHARS.collect { |search, replace| search }
  RE_EXTRA_CHARS = Regexp.union(*patterns)



  base = Hashery::Dictionary.new
  base['a'] = '     àáâă  äãā  åạą ảấầắằ а ª æ    '
  base['A'] = '     ÀÁÂĂ  ÄÃĀ  ÅẠĄ ẢẤẦẮẰ А ª Æ    '
  base['b'] = '     ḃб           ' 
  base['B'] = '     ḂБ                 ' 
  base['c'] = '     ćĉč çċ цч           '
  base['C'] = '     ĆĈČ ÇĊ ЦЧ            '
  base['d'] = '     ḋď ðđ д            '
  base['D'] = '     ḊĎ ÐĐ Д            '
  base['e'] = '     èéêěĕ  ëēėę  ế еэ         '
  base['E'] = '     ÈÉÊĚĔ  ËĒĖĘ  Ế ЕЭ         '
  base['f'] = '     ḟф  '
  base['F'] = '     ḞФ  '
  base['g'] = '     ĝğġ ģ г           '
  base['G'] = '     ĜĞĠ Ģ Г           '
  base['h'] = '     ĥħ х                '
  base['H'] = '     ĤĦ Х                '
  base['i'] = '     ìíîĭ ïĩīı     į   ий'
  base['I'] = '     ÌÍÎĬ ÏĨĪİ     Į   ИЙ'
  base['j'] = '	    ĵ юя    '
  base['J'] = '	    Ĵ ЮЯ    '
  base['k'] = '     ķĸ к        '
  base['K'] = '     Ķĸ К      '
  base['l'] = '     ĺ ľłļŀ л     '
  base['L'] = '     Ĺ ĽŁĻĿ Л     '
  base['m'] = '     ṁм   '
  base['M'] = '     ṀМ   '
  base['n'] = '     ńň  ñņŉŋ н     '
  base['N'] = '     ŃŇ  ÑŅŉŊ Н     '
  base['o'] = '     òóôŏ öõō  øőơ œ о      '
  base['O'] = '     ÒÓÔŎ ÖÕŌ  ØŐƠ Œ О      '
  base['p'] = '     п   '
  base['P'] = '     П   '
  base['q'] = nil
  base['Q'] = nil
  base['r'] = '     ŕř  ŗ р           '
  base['R'] = '     ŔŘ  Ŗ Р           '
  base['s'] = '     ṡśŝš ßş сшщ          '
  base['S'] = '     ṠŚŜŠ ßŞ СШЩ          '
  base['t'] = '     ṫţťŧþ т        '
  base['T'] = '     ṪŢŤŦÞ Т        '
  base['u'] = '     ùúûŭ üũū  ůűųư у	     '
  base['U'] = '     ÙÚÛŬ ÜŨŪ  ŮŰŲƯ У	     '
  base['v'] = '     в'
  base['V'] = '     В               '
  base['w'] = '     ŵ               '
  base['W'] = '     Ŵ               '
  base['x'] = nil
  base['X'] = nil
  base['y'] = '     ýŷ   ÿ      '
  base['Y'] = '     ÝŶ   Ÿ      '
  base['z'] = '     źżž жз   '
  base['Z'] = '     ŹŻŽ ЖЗ   '
  
  



  allkeys = 'abcdefghijklmnopqrstuvwxyz'
  #allkeys = 'snk'

  # Spaces entfernen
  allkeys.split(//).each do |key|
    next unless base[key]
    next if base[key].nil?
    # base[key].strip!.gsub!(' ','').gsub!(' ','')
    base[key].strip!.gsub!(' ','')
    base[key.upcase].strip!.gsub!(' ','')
  end


  # upcase und downcase
  tr_upcase = ''
  tr_downcase = ''
  allkeys.split(//).each do |key|
    next unless base[key]
    tr_downcase += base[key]   
    tr_upcase   += base[key.upcase]  
  end
  
  tr_upcase2       = ''
  tr_downcase2     = ''
  tr_downcase_only = ''
  tr_upcase.split(//).each_with_index do |c, i|
    if c == tr_downcase[i..i]   
      tr_downcase_only += c
    else
      tr_upcase2   += c
      tr_downcase2 += tr_downcase[i..i]   
    end
  end  
  
 
  

TR_DOWNCASE_ONLY = tr_downcase_only


  # reduce alphabet
  tr_full    = ''
  tr_reduced = ''
  allkeys.split(//).each do |key|
    next unless base[key]     
    tr_full    += base[key]       
    # tr_reduced += key * base[key].jsize               
    tr_reduced += key * base[key].size               
    tr_full    += base[key.upcase]   
    # tr_reduced += key.upcase * base[key.upcase].jsize  
    tr_reduced += key.upcase * base[key.upcase].size   
  end
  
  tr_full2    = ''
  tr_reduced2 = ''  
  tr_full.split(//).each_with_index do |c, i|
    next if ( TR_DOWNCASE_ONLY.include?(c)                          && 
              (tr_reduced[i..i] == tr_reduced[i..i].upcase)   )
      tr_full2    += c
      tr_reduced2 += tr_reduced[i..i]
  end
  

  TR_UPCASE    =        tr_upcase2
  TR_DOWNCASE  =        tr_downcase2
  TR_FULL      =        tr_full2  + tr_full_b
  TR_REDUCED   =        tr_reduced2  + tr_reduced_b
  TR_FULL_TO_ASCII =    tr_full_b + tr_full_c
  TR_REDUCED_TO_ASCII = tr_reduced_b + tr_reduced_c
  TR_UPCASE_ALL_REGEXP = /^[A-ZÀÁÂĂÄÃĀÅẠĄÆẢẤẦẮẰАБĆĈČÇĊЦЧĎÐĐДÈÉÊĚĔËĒĖĘẾЕЭФĜĞĠĢГĤĦХÌÍÎĬÏĨĪİĮĲИЙĴЮЯĶКĹĽŁĻĿЛМŃŇÑŅŊНÒÓÔŎÖÕŌØŐƠŒОПŔŘŖРŚŜŠŞСШЩŢŤŦÞТÙÚÛŬÜŨŪŮŰŲƯУВŴÝŶŸŹŻŽЖЗ]/   
  
  

LANG_SPECIAL_CHARS = {
  :german =>    ["ÄÖÜäöüß",   "AeOeUeaeoeuess"],
  :dutch =>     ["Ĳĳ",        "IJij"],
  :estonian =>  ["ŠšŽž",      "ShshZhzh"],
  :finnish =>   ["ŠšŽž",      "ShshZhzh"],
  :french =>    ["ŒœŸ",       "OEoeY"],
  :hungarian => ["ŐőŰű",      "OoUu"],
  :latin =>     ["ĀāĒēĪīŌōŪū","AaEeIiOoUu"],
  :finnish =>   ["ĀāĒēĪīŌōŪū","AaEeIiOoUu"],
  :turkish =>   ["İıĞğŞş",    "IiGgSs"],
  :welsh =>     ["ẀẁẂẃŴŵŶŷ",  "WwWwWwYy"],
  :irish  =>    ["ḂḃĊċḊḋḞḟĠġṀṁṠṡṪṫ", "BhbhChchDhdhFhfhGhghMhmhShshThth"]
}  
 
 # :irish  =>    ["ḂḃḊḋḞḟṀṁṠṡṪṫ", "BhbhChchDhdhFhfhGhghMhmhShshThth"]  
  
  
  
end # unless defined?


  class String

    # @private
    def to_ascii_extra_chars
      result = tr(TR_FULL_TO_ASCII, TR_REDUCED_TO_ASCII)  
      result.gsub(RE_EXTRA_CHARS) do |match|
        TR_EXTRA_CHARS.detect{ |search, replace| search =~ match}[1]
      end	
    end 
    
    # @private
    def to_ascii_minus
    
    end
    
  end # class



# -----------------------------------------------------------------------------------------
# TR_EXTRA_CHARS und TR_FULL manuell prüfen
#
if $0 == __FILE__ then
  require 'kyanite/string/chars'  
  require 'kyanite/set'  

  

  # Überprüfe TR_EXTRA_CHARS
  see
  see "Überprüfe TR_EXTRA_CHARS"
  see "========================"
  see
  see "defined in", "Dup if <>0", "Trivial?", "Hex Code", "Character", "reduce94", "to_ascii", "Klassifizierung"
  startline = 14
  i = 0
  all = ""
  TR_EXTRA_CHARS[0..-2].each do | a |
    c = a[0].to_s[7]
    all += c
    see i+startline,                      # Definitionszeile
    all.to_a.to_set.size-i-1,             # Dup-Detector
    (c.to_array_of_codepoints[0] <= 127 ? 'TRIVIAL':''), # Trivial-Detector
    c.to_array_of_hex,                    # sein Code in HEX    
    c,                                    # das Zeichen
    c.reduce94,                           # was reduce94 daraus macht
    c.to_ascii,                           # was to_ascii daraus macht
    UnicodeUtils.char_type(c)
    
    i+=1
  end
  
  # Überprüfe TR_FULL
  see
  see
  see
  see "Überprüfe TR_FULL"
  see "================="
  see  
  see "Nr", "Dup if <>0", "Trivial?", "Hex Code", "Character", "reduce94", "to_ascii", "Klassifizierung"  
  i = 0
  all = ""  
  #TR_FULL_TO_ASCII.each_char do |c|
  TR_FULL.each_char do |c|
    all += c
    see i,
    all.to_a.to_set.size-i-1,         # Dup-Detector
    (c.to_array_of_codepoints[0] <= 127 ? 'TRIVIAL':''), # Trivial-Detector
    c.to_array_of_hex,                    # sein Code in HEX    
    c,                                    # das Zeichen
    c.reduce94,                           # was reduce94 daraus macht    
    c.to_ascii,                           # was to_ascii daraus macht  
    UnicodeUtils.char_type(c)
    
    i+=1    
  end




end















