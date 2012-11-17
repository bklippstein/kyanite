# ruby encoding: utf-8
# ü
if $0 == __FILE__ 
  require 'drumherum'
  smart_init 
  require 'perception'
end

require 'kyanite/string/chars'
require 'kyanite/string/misc'

extra_chars = [
[/°/, ''],    #
[/§/, ''],    #
[/ß/, 'ss'],  #
[/€/, 'EUR'], #
[/´/, "'"],   # wird sonst in Space umgesetzt
[/¡/, '!'],
[/¿/, '?'],
[/¦/, '|'],
[/Ø/, 'O'],
[/ø/, 'o'],
[/æ/, 'ae'], 
[/Æ/, 'AE'],
[/œ/, 'oe'], 
[/Œ/, 'OE'],
[/ð/, 'd'],
[/đ/, 'd'],
[/Ð/, 'D'],
[/Đ/, 'D'],
[/ħ/, 'h'],
[/Ħ/, 'H'],
[/ı/, 'i'],
[/ĸ/, 'k'],
[/ł/, 'l'],
[/Ł/, 'L'],
[/ŋ/, 'nj'],
[/Ŋ/, 'NJ'],
[/ø/, 'o'],
[/œ/, 'oe'],
[/Ø/, 'O'],
[/Œ/, 'OE'],
[/ŧ/, 't'],
[/þ/, 't'],
[/Ŧ/, 'T'],
[/Þ/, 'T'],
[/¢/, 'c'],
[/£/, 'L'],
[/¤/, ''],
[/¥/, ''],
[/©/, '(c)'],
[/®/, '(r)'],
[/«/, '"'],
[/»/, '"'],
[/¬/, '-'],
[/±/, '+/-'],
[/¼/, '1/4'],
[/½/, '1/2'],
[/¾/, '3/4'],
[/×/, 'x'],
[/÷/, '/'],
[/‚/, ','],
[/‘/, "'"],
[/’/, "'"],
[/“/, '"'],
[/„/, '"'],
[/”/, '"'],
[/‹/, '"'],
[/›/, '"'],
[/ƒ/, 'f'],
[/•/, '*'],
[/†/, ''],
[/‡/, ''],
[/–/, '-'],
[/—/, '-'],
[/ˆ/, '^'],
[/‰/, '%%'],
[/˜/, '~']

]

i = 13
all = ""
extra_chars.each do | a |
  c = a[0].to_s[7]
  all += c
  see i, c, c.to_array_of_hex, c.to_ascii, c.to_ascii.to_array_of_hex, 12 + all.squeeze.size - i 
  i+=1
end


#see "betwæen".mgsub(extra_chars)  

full    = ''

i = 0
full.each_char do |c|
  see i, c, c.to_array_of_hex, c.to_ascii, c.to_ascii.to_array_of_hex
  i += 1
end  
see    



    ffi = "\uFB03"
    ix = "\u2168"
    high5 = "\u2075"
    all = ffi + ix + high5
    #see all.to_ascii



# test = ffi.split(//).collect do |x|
  # x.match(/\d/) ? x : x.unpack('U')[0].to_s(16)
# end




    