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
# see leerzeichen.reduce.to_array_of_hex, leerzeichen.reduce94.to_array_of_hex

auslagerung = "\ue000-\uf8ff"

result = "HalloßàáâăäãāåạąæảấầắằÀÁÂĂÄÃĀÅẠĄÆẢẤẦẮẰćĉčçċĆĈČÇĊß"
#see result.reduce(:preserve => "Äß")

result.tr!("Äß", auslagerung)
result = result.reduce
result.tr!(auslagerung, "Äß")
#see result
#see result



    full = <<ENDOFSTRING
ßàáâăäãāåạąæảấầắằÀÁÂĂÄÃĀÅẠĄÆẢẤẦẮẰćĉčçċĆĈČÇĊďðđĎÐĐèéêěĕëēėęếÈÉÊĚĔËĒĖĘẾĝğġģĜĞĠĢĥħĤĦìíîĭïĩīıįĳÌÍÎĬÏĨĪİĮĲĵĴķĶĺľłļŀĹĽŁĻĿńňñņŉŋŃŇÑŅŊòóôŏöõōøőơœÒÓÔŎÖÕŌØŐƠŒŕřŗŔŘŖśŝšßşŚŜŠŞţťŧþŢŤŦÞùúûŭüũūůűųưÙÚÛŬÜŨŪŮŰŲƯŵŴýŷÿÝŶŸźżžŹŻŽ
ENDOFSTRING
see
result = ""
10000.times do
  #result = full.reduce94
  result = full.reduce(  )
  

  
end
#see result
see seee.bench




#see "betwæen".mgsub(TR_EXTRA_CHARS)  


full = %q{≺≻≪≫}  
#see full

i = 0
see "Nr", "Char", "reduce", "reduce", "Hex Char",  "Hex reduce", "Hex reduce"
full.each_char do |c|
  see i, c, c.reduce, c.reduce94, c.to_array_of_hex, c.reduce.to_array_of_hex, c.reduce94.to_array_of_hex
  i += 1
end  
see    



# test = ffi.split(//).collect do |x|
  # x.match(/\d/) ? x : x.unpack('U')[0].to_s(16)
# end




    