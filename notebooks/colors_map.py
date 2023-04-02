color_map = {
"00":"c64_black",  
"01":"c64_white",  
"02":"c64_red",    
"03":"c64_cyan",   
"04":"c64_purple", 
"05":"c64_green",  
"06":"c64_blue",   
"07":"c64_yellow", 
"08":"c64_orange", 
"09":"c64_brown",  
"0a":"c64_ltred",  
"0b":"c64_gray1",  
"0c":"c64_lightgray",  
"0d":"c64_ltgreen",
"0e":"c64_ltblue", 
"0f":"c64_gray3",  
}
c64_to_rgb = {
"c64_black": "#000000",     
"c64_white": "#ffffff",     
"c64_red": "#880000",       
"c64_cyan":  "#aaffee",     
"c64_purple": "#cc44cc",    
"c64_green": "#00cc55",     
"c64_blue":  "#0000aa",     
"c64_yellow":  "#eeee77",   
"c64_orange":  "#dd8855",   
"c64_brown": "#664400",     
"c64_ltred": "#ff7777",  
"c64_gray1":  "#333333",    
"c64_lightgray": "#bbbbbb", 
"c64_ltgreen": "#aaff66",
"c64_ltblue":  "#0088ff",
"c64_gray3": "#bbbbbb",                             
}
hex_to_rgb = {
"00": "#000000",     
"01": "#ffffff",     
"02": "#880000",       
"03":  "#aaffee",     
"04": "#cc44cc",    
"05": "#00cc55",     
"06":  "#0000aa",     
"07":  "#eeee77",   
"08":  "#dd8855",   
"09": "#664400",     
"0a": "#ff7777",  
"0b":  "#333333",    
"0c": "#bbbbbb", 
"0d": "#aaff66",
"0e":  "#0088ff",
"0f": "#bbbbbb",                             
}

fhex_to_rgb = {
"f0": "#000000",     
"f1": "#ffffff",     
"f2": "#880000",       
"f3":  "#aaffee",     
"f4": "#cc44cc",    
"f5": "#00cc55",     
"f6":  "#0000aa",     
"f7":  "#eeee77",   
"f8":  "#dd8855",   
"f9": "#664400",     
"fa": "#ff7777",  
"fb":  "#333333",    
"fc": "#bbbbbb", 
"fd": "#aaff66",
"fe":  "#0088ff",
"ff": "#bbbbbb",                             
}

color_constants = """
BLACK        = $00
WHITE        = $01
RED          = $02
CYAN         = $03
PURPLE       = $04
GREEN        = $05
BLUE         = $06
YELLOW       = $07
ORANGE       = $08
BROWN        = $09
LTRED        = $0A
GRAY1        = $0B
GRAY2        = $0C
LTGREEN      = $0D
LTBLUE       = $0E
GRAY3        = $0F
""".split('\n')[1:-1]
color_constants = {c.split('=')[0].strip():hex_to_rgb[c[-2:].lower()] for c in color_constants}

