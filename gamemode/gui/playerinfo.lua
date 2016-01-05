Playerinfo = {}

local function draw(count, text, color)
	local t_font = "ProgBar"
	local height = draw.GetFontHeight(t_font)
	local init_margin = 20
	
	local t_x = ScrW()/2
	local t_y = ScrH() / 2 + init_margin + (height*1.5)*(count-1)
	
	local text_table = {
		text = text,
		font = t_font
		pos = {t_x, t_y},
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_TOP,
		color = color
	}
	draw.Text(text_table)
	draw.TextShadow(text_table, 2, 255)
end

Playerinfo.draw = draw