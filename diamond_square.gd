#-----------------------------------------------
# COPYRIGHT
#-----------------------------------------------

# The 'diamond_square()' function is based on the source code found in link provided below:
#
# -- https://github.com/whiteboxdev/example-diamond-square
#
# -- Copyright (c) 2024 White Box Dev

# -- This software is provided 'as-is', without any express or implied warranty.
# -- In no event will the authors be held liable for any damages arising from the use of this software.

# -- Permission is granted to anyone to use this software for any purpose,
# -- including commercial applications, and to alter it and redistribute it freely,
# -- subject to the following restrictions:

# -- 1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software.
# --    If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.

# -- 2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.

# -- 3. This notice may not be removed or altered from any source distribution.

#-----------------------------------------------

extends ColorRect

const EXPONENT = 10

const RANDOM_SCALAR : float = 96
const HEIGHT_MIN : int = 1
const HEIGHT_MAX : int = 18

var r : RandomNumberGenerator


func _ready() -> void:
	r = RandomNumberGenerator.new()
	r.randomize()

	var e = clamp(EXPONENT, 0, 12)
	var map_size = int(pow(2, e) + 1)
	var map = diamond_square(map_size)
	
	draw_map(map, map_size, true)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("p_spawn"):
		var e = clamp(EXPONENT, 0, 12)
		var map_size = int(pow(2, e) + 1)
		var map = diamond_square(map_size)
		draw_map(map, map_size, true)


func diamond_square(map_size : int):
	var sum
	var count
	var avg
	var half
	var r_scale = RANDOM_SCALAR
	var size_max = map_size - 1
	var chunk_size = map_size - 1

	var map = []
	for x in range(map_size):
		map.append([])
		for y in range(map_size):
			map[x].append(0.00)

	while(chunk_size > 1):
		half = int(chunk_size / 2.0)

		# square step
		for x in range(0, size_max, chunk_size):
			for y in range(0, size_max, chunk_size):
				avg = (map[x][y] + map[x][y + chunk_size] + map[x + chunk_size][y] + map[x + chunk_size][y + chunk_size]) / 4
				avg += r.randf_range(-1.0, 1.0) * r_scale
				map[x + half][y + half] = round_height(avg)

		# diamond step
		for x in range(0, map_size, half):
			for y in range((x + half) % chunk_size, map_size, chunk_size):
				sum = 0
				count = 0
				if y - half > 0:
					sum += map[x][y - half]
					count += 1
				if y + half < map_size:
					sum += map[x][y + half]
					count += 1
				if x - half > 0:
					sum += map[x-half][y]
					count += 1
				if x + half < map_size:
					sum += map[x + half][y]
					count += 1

				sum = sum / count - r.randf_range(-1.0, 1.0) * r_scale

				# if falloff negate height at the borders of the grid; border width is 2 pixels
				map[x][y] += -map[x][y] if (x <= 1 || y <= 1 || x >= map_size - 2 || y >= map_size - 2) else  round_height(sum)
				# else no falloff
				#map[x][y] += round_height(sum)

		chunk_size /= 2
		r_scale = max(r_scale / 2, 0.1)

	return map


func round_height(h : float):
	var m = floor(h) if abs(ceil(h) - h) > abs(h - floor(h)) else ceil(h)
	return max(min(m, HEIGHT_MAX), HEIGHT_MIN)


func draw_map(height_map : Array, map_size : int, do_draw : bool):
	var image = Image.create(map_size, map_size, false, Image.FORMAT_RGB8)
	var tex = ImageTexture.create_from_image(image)
	var v_range = HEIGHT_MAX - HEIGHT_MIN
	var nv

	for px in range(map_size):
		for py in range(map_size):
			nv = (height_map[px][py] - HEIGHT_MIN) / v_range
			image.set_pixel(px, py, Color8(255, 255, 255) * nv)

	if do_draw:
		tex.update(image)
		material.set_shader_parameter("c0", tex)

    # save image to res
	#var s = str(r.get_seed()).left(7)
	#image.save_png("res://" + "img" + s + ".png")
