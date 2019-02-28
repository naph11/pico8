pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
function _init()
	cls(1)
	mode="start"
end

function _update60()
if mode=="game" then
		update_game()
	elseif mode=="start" then
		update_start()
	elseif mode=="gameover" then
		update_gameover()
	circfill(ball_x,ball_y,ball_radius,ball_color)
	rectfill(pad_x,pad_y,pad_x+pad_width,pad_y+pad_height,pad_color)
	end
end

function update_start()
	if btn(5) then
		startgame()
	end
end

function startgame()
mode="game"
col=1
t=0
music(8)
mus=0
music()
serveball()
	
lives=3
	
ball_radius=2
ball_color=10

pad_x=52
pad_y=120
pad_dx=0
pad_width=24
pad_height=3
pad_color=7
 
layer1_x=0
layer1_a=-128
layer1_y=11

layer2_x=0
layer2_a=-128
layer2_y=13
 
star=0
star_ani={52,53,49,50,51}
ministar_ani={33,33,34,35}
end

function serveball()
	ball_x=3
	ball_y=28
	ball_dx=1
	ball_dy=1
end

function gameover()
	mode="gameover"
end

function update_gameover()
t+=0
layer1_x+=0
layer1_a+=0
layer2_x+=0
layer2_a+=0
	if btn(5) then
		startgame()
	end
end

function update_game()
cls()
map()
t+=1
mus+=0.5
star+=0.05

--music
	if mus>=319 then mus=0
	end
	if mus==0 then
		music(0)
	end
	
--controls
 btnpress=false
--left
	if btn(0) then
		--pad_x-=1.5
		pad_dx=-1.5
		btnpress=true
	end
--right
	if btn(1) then
	 --pad_x+=1.5
	 pad_dx=1.5
	 btnpress=true
	end
	if not (btnpress) then
		pad_dx=pad_dx/2
	end
	pad_x+=pad_dx
		
--next ball position
 next_x = ball_x+ball_dx
 next_y = ball_y+ball_dy
	
--wall collision
	if next_x>124 or next_x<3 then
	next_x=mid(3,next_x,124)
	next_x=mid(3,next_x,124)
	ball_dx=-ball_dx
	sfx(12)
	end
	if next_y<10 then
	next_y=mid(0,next_y,125)
	ball_dy=-ball_dy
	sfx(12)
	end
--vertical collision
	if ball_box(next_x,next_y,pad_x,pad_y,pad_width,pad_height) then
		if deflx_ballbox(ball_x,ball_y,ball_dx,ball_dy,pad_x,pad_y,pad_width,pad_height) then
			ball_dx=-ball_dx
		else
			ball_dy=-ball_dy
		end
	 sfx(13)
	end
	ball_x=next_x
	ball_y=next_y
	if next_y==125 then
		if lives==0 then
			sfx(15)
			gameover()
		end
	elseif ball_y==128 then
		sfx(14)
		lives-=1
		serveball()
	end
end

function draw_start()
	cls()
	rectfill(41,50,86,62,1)
	print("st★r ball",45,54,7)
	print("press ❎ to start", 32, 80, 7)
	
	rectfill(0,0,128,0,14)
	rectfill(0,0,0,128,14)
	rectfill(127,0,128,128,14)
	rectfill(0,127,128,128,14)
end

function draw_gameover()
--sprites don't load 😐ˇ
	rectfill(0,0,128,6,14)
	rectfill(0,0,0,128,14)
	rectfill(127,0,128,128,14)
	rectfill(0,127,128,128,14)
	print("lives:😐",3,1,7)
	
	rectfill(0,59,128,75,14)
	print("game over",46,62,7)
	print("press ❎ to restart",26,68,7)
	music(8)
	
	--print("whyyy",20,90,7)
end

function draw_game()
	cls()
	map()
--background layer 1
	--todo make fluffier clouds
	--todo optimize w/ arrays

	--todo noticeable split between layer loops. fix using arrays to load in new sprites?
	--todo learn arrays lol
layer1_x+=0.0125
layer1_a+=0.0125
if layer1_x>=128 then layer1_x=-128 end
if layer1_a>=128 then layer1_a=-128 end

spr(1,layer1_x,layer1_y*8)
spr(2,layer1_x+8,layer1_y*8)
spr(1,layer1_x+16,layer1_y*8)
spr(2,layer1_x+24,layer1_y*8)
spr(3,layer1_x+32,layer1_y*8)
spr(4,layer1_x+40,layer1_y*8)
spr(5,layer1_x+48,layer1_y*8)
spr(6,layer1_x+56,layer1_y*8)
spr(1,layer1_x+64,layer1_y*8)
spr(2,layer1_x+72,layer1_y*8)
spr(1,layer1_x+80,layer1_y*8)
spr(2,layer1_x+88,layer1_y*8)
spr(3,layer1_x+96,layer1_y*8)
spr(4,layer1_x+104,layer1_y*8)
spr(5,layer1_x+112,layer1_y*8)
spr(6,layer1_x+120,layer1_y*8)

--new layer 1

spr(1,layer1_a,layer1_y*8)
spr(2,layer1_a+8,layer1_y*8)
spr(1,layer1_a+16,layer1_y*8)
spr(2,layer1_a+24,layer1_y*8)
spr(3,layer1_a+32,layer1_y*8)
spr(4,layer1_a+40,layer1_y*8)
spr(5,layer1_a+48,layer1_y*8)
spr(6,layer1_a+56,layer1_y*8)
spr(1,layer1_a+64,layer1_y*8)
spr(2,layer1_a+72,layer1_y*8)
spr(1,layer1_a+80,layer1_y*8)
spr(2,layer1_a+88,layer1_y*8)
spr(3,layer1_a+96,layer1_y*8)
spr(4,layer1_a+104,layer1_y*8)
spr(5,layer1_a+112,layer1_y*8)
spr(6,layer1_a+120,layer1_y*8)

--layer 2
	--raise by ~6 pixels, make fluffier

if layer2_x>=128 then layer2_x=-128 end
if layer2_a>=128 then layer2_a=-128 end
layer2_x+=.05
layer2_a+=.05
spr(9,layer2_x+8,layer2_y*8)
spr(10,layer2_x+40,layer2_y*8)
spr(11,layer2_x+48,layer2_y*8)
spr(9,layer2_x+72,layer2_y*8)
spr(10,layer2_x+104,layer2_y*8)
spr(11,layer2_x+112,layer2_y*8)

spr(12,layer2_x,layer2_y*8+8)
spr(13,layer2_x+8,layer2_y*8+8)
spr(14,layer2_x+16,layer2_y*8+8)
spr(15,layer2_x+24,layer2_y*8+8)
spr(16,layer2_x+32,layer2_y*8+8)
spr(17,layer2_x+40,layer2_y*8+8)
spr(18,layer2_x+48,layer2_y*8+8)
spr(19,layer2_x+56,layer2_y*8+8)
spr(12,layer2_x+64,layer2_y*8+8)
spr(13,layer2_x+72,layer2_y*8+8)
spr(14,layer2_x+80,layer2_y*8+8)
spr(15,layer2_x+88,layer2_y*8+8)
spr(16,layer2_x+96,layer2_y*8+8)
spr(17,layer2_x+104,layer2_y*8+8)
spr(18,layer2_x+112,layer2_y*8+8)
spr(19,layer2_x+120,layer2_y*8+8)

--new layer 2

spr(9,layer2_a+8,layer2_y*8)
spr(10,layer2_a+40,layer2_y*8)
spr(11,layer2_a+48,layer2_y*8)
spr(9,layer2_a+72,layer2_y*8)
spr(10,layer2_a+104,layer2_y*8)
spr(11,layer2_a+112,layer2_y*8)

spr(12,layer2_a,layer2_y*8+8)
spr(13,layer2_a+8,layer2_y*8+8)
spr(14,layer2_a+16,layer2_y*8+8)
spr(15,layer2_a+24,layer2_y*8+8)
spr(16,layer2_a+32,layer2_y*8+8)
spr(17,layer2_a+40,layer2_y*8+8)
spr(18,layer2_a+48,layer2_y*8+8)
spr(19,layer2_a+56,layer2_y*8+8)
spr(12,layer2_a+64,layer2_y*8+8)
spr(13,layer2_a+72,layer2_y*8+8)
spr(14,layer2_a+80,layer2_y*8+8)
spr(15,layer2_a+88,layer2_y*8+8)
spr(16,layer2_a+96,layer2_y*8+8)
spr(17,layer2_a+104,layer2_y*8+8)
spr(18,layer2_a+112,layer2_y*8+8)
spr(19,layer2_a+120,layer2_y*8+8)
	
--stars

spr(star_ani[flr(t/4)%5+1],star/16+20,-star/16+48)
spr(star_ani[flr(t/4)%5+1],star/16+28,-star/16+70)
spr(star_ani[flr(t/4)%5+1],star/16+45,-star/16+25)
spr(star_ani[flr(t/4)%5+1],star/16+63,-star/16+37)
spr(star_ani[flr(t/4)%5+1],star/16+90,-star/16+27)
spr(star_ani[flr(t/4)%5+1],star/16+110,-star/16+23)
	
spr(ministar_ani[flr(t/4.55)%4+1],star/16+35,-star/16+32)
spr(ministar_ani[flr(t/4.55)%4+1],star/16+41,-star/16+35)
spr(ministar_ani[flr(t/4.55)%4+1],star/18+26,-star/16+30)
spr(ministar_ani[flr(t/4.55)%4+1],star/18+80,-star/16+10)
spr(ministar_ani[flr(t/4.55)%4+1],star/18+70,-star/16+62)
spr(ministar_ani[flr(t/4.55)%4+1],star/18+83,-star/16+73)
	
spr(33,star/16+31,-star/16+36)
spr(33,star/16+5,-star/16+50)
spr(33,star/16+2,-star/16+73)
spr(33,star/16+13,-star/16+42)
spr(33,star/16+100,-star/16+75)
spr(33,star/16+33,-star/16+24)
spr(33,star/16+50,-star/16+60)
spr(33,star/16+12,-star/16+68)

--ball+pad

circfill(ball_x,ball_y,ball_radius,ball_color)
rectfill(pad_x,pad_y,pad_x+pad_width,pad_y+pad_height,pad_color)
rectfill(0,0,128,6,14)
rectfill(0,0,0,128,14)
rectfill(127,0,128,128,14)
rectfill(0,127,128,128,14)
print("lives:"..lives,3,1,7)
end

function _draw()
	if mode=="game" then
		draw_game()
	elseif mode=="start" then
		draw_start()
	elseif mode=="gameover" then
		draw_gameover()
	end
end

function ball_box(bx,by,box_x,box_y,box_w,box_h)
 --ball/pad collision
	if by-ball_radius > box_y+box_h then
		return false
	end
	if by+ball_radius < box_y then
		return false
	end
	if bx-ball_radius > box_x+box_w then
		return false
	end
	if bx+ball_radius < box_x then
		return false
	end
	return true
end

function deflx_ballbox(bx,by,bdx,bdy,tx,ty,tw,th)
	if bdx == 0 then
		return false
	elseif bdy == 0 then
		return true
	else
		local slope=bdy/bdx
		local cx,cy
--down right
		if slope>0 and bdx>0 then
			cx=tx-bx
			cy=ty-by
			if cx<=0 then
				return false
			elseif cy/cx < slope then
				return true
			else
				return false
			end
--up right
		elseif slope<0 and bdx>0 then
			cx=tx-bx
			cy=ty+th-by
			if cx<=0 then
				return false
			elseif cy/cx < slope then
				return false
			else
				return true
			end
--up left
		elseif slope>0 and bdx<0 then
			cx=tx+tw-bx
			cy=ty+th-by
			if cx>=0 then
				return false
			elseif cy/cx>slope then
				return false
			else
				return true
			end
--down left
		else
			cx=tx+tw-bx
			cy=ty-by
			if cx>=0 then
				return false
			elseif cy/cx<slope then
				return false
			else
				return true
			end
		end
	end
return false
end 

__gfx__
0000000000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111d1d1dd1dd1d11111111111111
0000000010001000000000001000000000000000000000000000011011111101110111111111111111111111111111111111d1ddddddddd1d1d1111111111111
0070070001010101000100010101100000000000000000000000100110111111111110111111111111111111111111111d1d1d1ddddddddd1d1d1d1111111111
000770001010101010101010101001000000000000000000010101101111111111111111111111111111111111d11111d1d1dddddd1dddddddd1d1d111111111
000770001101110101010101110110111010000000000101101011111111111111111111111111111111111d1d1d1111dd1d1ddddddd1ddddddddddd1d111111
00700700101010111011101110111101010101000010101001010111111111111111111111111111111111d1d1d1d111d1d1dddddddddddddd1ddd1dd1d1d111
0000000011110111110111011111111110101010010101011111111111111111111111111d11d111111d1d1d1d1d1d11ddddd1dddddddddddddddddddd1d1d1d
000000001111111101111111111111111111110110111111111111011111111111111111d1dd1dd1d1d1d1ddddddd1d1ddddddddddddddddddddddddddddd1d1
11111d1d1d1ddddddddd1d1111111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111d1d1dddd1dddddddd1d111111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
111d1d1dd1dddddddddddd1d1d1dd111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111ddddddddddddddddddd1d1d11d1d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
111d1ddddddddddddddddddd1d1dd1d1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11d1dd1ddddddddddddddddddddd1d1d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dd1ddddddddddddddddddddddddddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d1dddddddddddddddddddddddddddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd000000000000700000070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd000070000007070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd000000000000700000070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111000000000000700000007000007707700070007000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111000070000000700000077700007000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111000777000077777000770770000000000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111000070000000700000077700007000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111000000000000700000007000007707700070007000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1919191919191919191900000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191919191900000000002a2a0000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191919191900000019002a2a0000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
19191919191919190000002a2a00000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2a191919192a0000000000000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2a002a2a2a2a2a2a2a0000000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2a00002a2a2a2a00000000000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2a000000002a2a00000000000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2a0000002a2a0000000000000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2a0000002a000000000000160000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2a00000000000000000000160000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1919191919191919191919191919191909000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3030303030303030303030303030303009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3030303030303030303030303030303009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3030303030303030303030303030303009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020202009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020202009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00050000340403402134011347002900029700000000000029040290212901129000300000f00000000000002d0402d0212d01134700290000000000000000003004030021300113100030000000000000000000
000500003404034021340113470029000297000000000000290402902129011310002f0000000000000000002d0402d0212d01134700290000000000000000002f0402f0212f011310002f000000000000000000
00050000320403202132011320002c5001a1001510011100280402802128011300002f00024100211001d1002b0402b0212b0111d1002800024100211001d1002f0402f0212f011300002f000281002410021100
000500000e0700e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e0710e071
000500001307013071130711307113071130711307113071130711307113071130711307113071130711307113071130711307113071130711307113071130711307113071130711307113071130711307113071
000500000c0700c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c0710c071
00050000000000000000000000000000000000000000000000000000000000000000000000000000000000002814024140211401d1401c1401a14015140111402813024130211301d1301c1301a1301513011130
000500002812024120211201d1201c1201a12015120111202811024110211101d1101c1101a11015110111101a10015100111001c1001a10015100111001d1001c1001a100151001110011100281002410021100
000500002810023100211001d1001c10017100151001110000000000000000000000000000000000000000002814023140211401d1401c1401714015140111402813023130211301d1301c130171301513011130
000500002812023120211201d1201c1201712015120111202811023110211101d1101c11017110151101111000000000000000000000000000000000000000000000000000000000000000000000000000000000
0005000026100231001f1001c1001a10017100131001010026100231001f1001c1001a10017100131001010026140231401f1401c1401a14017140131401014026130231301f1301c1301a130171301313010130
0005000026120231201f1201c1201a12017120131201012026110231101f1101c1101a11017110131101011000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300001735023350233500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300001c35028350283500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00030000173402334123341233401e3401e3401e3401e34022000220002200018100181001410013100101000c1000b1000c1000e1000d1000910006100041000310002100021000000000000000000000000000
000400003205032051320512f0402f0402f0402b0402b0402b0402803028030280302602026020260202302023020230202302023020230202302023020230202302123021230112301123000230002300023000
0003000020650246502565024650206501b650136500d6500b650096500865018100181001410013100101000c1000b1000c1000e1000d1000910006100041000310002100021000000000000000000000000000
__music__
00 00030644
00 00030744
00 01040644
00 01040744
00 02050a44
00 02050b44
00 02050a44
00 02050b44
00 41424344
00 4f424344

