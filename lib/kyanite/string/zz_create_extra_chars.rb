# ruby encoding: utf-8
# ü
require 'drumherum'
smart_init 
require 'perception'

require 'kyanite/string'
require 'kyanite/hash'

# see TR_FULL_TO_ASCII
# see TR_REDUCED_TO_ASCII



# leerzeichen= "\u0020"
# see leerzeichen.to_ascii.to_array_of_hex, leerzeichen.reduce94.to_array_of_hex



    full = <<ENDOFSTRING
àáâăäãāåạąæảấầắằÀÁÂĂÄÃĀÅẠĄÆẢẤẦẮẰćĉčçċĆĈČÇĊďðđĎÐĐèéêěĕëēėęếÈÉÊĚĔËĒĖĘẾĝğġģĜĞĠĢĥħĤĦìíîĭïĩīıįĳÌÍÎĬÏĨĪİĮĲĵĴķĶĺľłļŀĹĽŁĻĿńňñņŉŋŃŇÑŅŊòóôŏöõōøőơœÒÓÔŎÖÕŌØŐƠŒŕřŗŔŘŖśŝšßşŚŜŠŞţťŧþŢŤŦÞùúûŭüũūůűųưÙÚÛŬÜŨŪŮŰŲƯŵŴýŷÿÝŶŸźżžŹŻŽ
ENDOFSTRING
see
10000.times do
  full.to_ascii
end
see seee.bench




#see "betwæen".mgsub(TR_EXTRA_CHARS)  


full = %q{≺≻≪≫}  
see full

i = 0
see "Nr", "Char", "to_ascii", "reduce", "Hex Char",  "Hex to_ascii", "Hex reduce"
full.each_char do |c|
  see i, c, c.to_ascii, c.reduce94, c.to_array_of_hex, c.to_ascii.to_array_of_hex, c.reduce94.to_array_of_hex
  i += 1
end  
see    



# test = ffi.split(//).collect do |x|
  # x.match(/\d/) ? x : x.unpack('U')[0].to_s(16)
# end




    