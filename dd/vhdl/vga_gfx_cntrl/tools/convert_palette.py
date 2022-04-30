#!/bin/env python3

import sys

try:
	import png
except:
	print("module 'png' not found!")
	print("run the following command to install it (as user, not as root!)")
	print(" pip3 install --user pypng")
	exit(1)

img = png.Reader(sys.argv[1]).read_flat()
pixel_data = img[2]
if (img[3]["planes"] not in [3,4]):
	print("Color format not supported!")
	exit(1)
pixels = [pixel_data[i:i+img[3]["planes"]] for i in range(0, len(pixel_data), img[3]["planes"])] #separate rgba values into pixels 

for pix in pixels:
	r = round(pix[0] * 31/255)
	g = round(pix[1] * 63/255)
	b = round(pix[2] * 31/255)
	
	rgb = (r << (6+5)) + (g<<5) + b 
	print(hex(rgb) + " ", end="")

print()
