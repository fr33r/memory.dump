" Port/inspired from https://github.com/AlessandroYorba/Arcadia.
" Jon Freer

let s:gui_black = "#262626"
let s:cterm_black = 235

let s:gui_purple = "#875f87"
let s:cterm_purple = 96
let s:gui_purple_offset = "#8787af"
let s:cterm_purple_offset = 103

let s:gui_blue = "#5f87af"
let s:cterm_blue = 67
let s:gui_blue_offset = "#5fafff"
let s:cterm_blue_offset = 75

let s:gui_cyan = "#008787"
let s:cterm_cyan = 30
let s:gui_cyan_offset = "#00d7d7"
let s:cterm_cyan_offset = 44

let s:gui_pink = "#af5f87"
let s:cterm_pink = 132
let s:gui_pink_offset = "#d75f87"
let s:cterm_pink_offset = 168

let s:gui_white = "#FFFFFF"
let s:cterm_white = 255

let g:airline#themes#arcadia#palette = {}

let s:N1 = [ s:gui_black, s:gui_purple, s:cterm_black, s:cterm_purple ]
let s:N2 = [ s:gui_black, s:gui_purple_offset,  s:cterm_black, s:cterm_purple_offset ]
let s:N3 = [ s:gui_purple, s:gui_black, s:cterm_purple, s:cterm_black ]
let g:airline#themes#arcadia#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let s:I1 = [ s:gui_black, s:gui_blue, s:cterm_black, s:cterm_blue ]
let s:I2 = [ s:gui_black, s:gui_blue_offset, s:cterm_black, s:cterm_blue_offset ]
let s:I3 = [ s:gui_blue, s:gui_black, s:cterm_blue, s:cterm_black ]
let g:airline#themes#arcadia#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)

let s:V1 = [ s:gui_black, s:gui_cyan, s:cterm_black, s:cterm_cyan ]
let s:V2 = [ s:gui_black, s:gui_cyan_offset,  s:cterm_black, s:cterm_cyan_offset ]
let s:V3 = [ s:gui_cyan, s:gui_black, s:cterm_cyan, s:cterm_black ]
let g:airline#themes#arcadia#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

let s:R1 = [ s:gui_black, s:gui_white, s:cterm_black, s:cterm_white ]
let s:R2 = [ s:gui_black, s:gui_white, s:cterm_black, s:cterm_white ]
let s:R3 = [ s:gui_white, s:gui_black, s:cterm_white, s:cterm_black ]
let g:airline#themes#arcadia#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

let s:IA1 = [ s:gui_black, s:gui_pink, s:cterm_black, s:cterm_pink ]
let s:IA2 = [ s:gui_black, s:gui_pink_offset, s:cterm_black, s:cterm_pink_offset]
let s:IA3 = [ s:gui_pink, s:gui_black, s:cterm_pink, s:cterm_black ]
let g:airline#themes#arcadia#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
