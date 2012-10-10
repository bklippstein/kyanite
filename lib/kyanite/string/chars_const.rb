# ruby encoding: utf-8

require 'hashery' 
require 'kyanite/nil'
require 'kyanite/string/div'




unless defined?(TR_UPCASE_ALL_REGEXP)
  base = Hashery::Dictionary.new
  base['a'] = '     àáâă  äãā  åạą æ ảấầắằ а       '
  base['A'] = '     ÀÁÂĂ  ÄÃĀ  ÅẠĄ Æ ẢẤẦẮẰ А       '
  base['b'] = '     б           ' 
  base['B'] = '     Б                 ' 
  base['c'] = '     ćĉč çċ цч           '
  base['C'] = '     ĆĈČ ÇĊ ЦЧ            '
  base['d'] = '     ď ðđ д            '
  base['D'] = '     Ď ÐĐ Д            '
  base['e'] = '     èéêěĕ  ëēėę  ế еэ         '
  base['E'] = '     ÈÉÊĚĔ  ËĒĖĘ  Ế ЕЭ         '
  base['f'] = '     ф  '
  base['F'] = '     Ф  '
  base['g'] = '     ĝğġ ģ г           '
  base['G'] = '     ĜĞĠ Ģ Г           '
  base['h'] = '     ĥħ х                '
  base['H'] = '     ĤĦ Х                '
  base['i'] = '     ìíîĭ ïĩīı     į  ĳ ий'
  base['I'] = '     ÌÍÎĬ ÏĨĪİ     Į  Ĳ ИЙ'
  base['j'] = '	    ĵ юя    '
  base['J'] = '	    Ĵ ЮЯ    '
  base['k'] = '     ķĸ к        '
  base['K'] = '     Ķĸ К      '
  base['l'] = '     ĺ ľłļŀ л     '
  base['L'] = '     Ĺ ĽŁĻĿ Л     '
  base['m'] = '     м   '
  base['M'] = '     М   '
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
  base['s'] = '     śŝš ßş сшщ          '
  base['S'] = '     ŚŜŠ ßŞ СШЩ          '
  base['t'] = '     ţťŧþ т        '
  base['T'] = '     ŢŤŦÞ Т        '
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
    base[key].strip!.gsub!(' ','').gsub!(' ','')
    base[key.upcase].strip!.gsub!(' ','').gsub!(' ','')
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
  

  TR_UPCASE    = tr_upcase2
  TR_DOWNCASE  = tr_downcase2
  TR_FULL      = tr_full2
  TR_REDUCED   = tr_reduced2
  TR_UPCASE_ALL_REGEXP = /^[A-ZÀÁÂĂÄÃĀÅẠĄÆẢẤẦẮẰАБĆĈČÇĊЦЧĎÐĐДÈÉÊĚĔËĒĖĘẾЕЭФĜĞĠĢГĤĦХÌÍÎĬÏĨĪİĮĲИЙĴЮЯĶКĹĽŁĻĿЛМŃŇÑŅŊНÒÓÔŎÖÕŌØŐƠŒОПŔŘŖРŚŜŠŞСШЩŢŤŦÞТÙÚÛŬÜŨŪŮŰŲƯУВŴÝŶŸŹŻŽЖЗ]/   
  
end # unless defined?






# -----------------------------------------------------------------------------------------
# Ausprobieren
#
if $0 == __FILE__ then

  require 'perception'
  rawlog "\n----------------------------------------------------------\n\n"
  
  rawlog 'TR_DOWNCASE_ONLY=     '
  rawlog TR_DOWNCASE_ONLY
  rawlog "\n" 
  
  rawlog 'TR_FULL=     '
  rawlog TR_FULL
  rawlog "\n"
  rawlog 'TR_REDUCED=  '
  rawlog TR_REDUCED
  rawlog "\n"  
  
  rawlog 'TR_UPCASE=   '
  rawlog TR_UPCASE
  rawlog "\n"
  rawlog 'TR_DOWNCASE= '
  rawlog TR_DOWNCASE
  rawlog "\n"
  






end















