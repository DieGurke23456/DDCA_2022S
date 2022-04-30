#!/bin/env python3

import sys

try:
	import png
except:
	print("module 'png' not found!")
	print("run the following command to install it (as user, not as root!)")
	print(" pip3 install --user pypng")
	exit(1)

img = png.Reader(sys.argv[1]).read()

if img[0] != img[1]:
	print("width and height must be equal!")
	exit()

mem_size = img[0]*img[1]

print(f"""
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.gfx_util_pkg.all;

package bb_mem_pkg is

	constant MEMORY_CONTENTS : bb_mem_t(0 to {mem_size-1}) := (""")

line_n = 0
for line in img[2]:
	output = "\t" + ", ".join(['x"' + hex(int(pix/255*15))[2:] + '"' for pix in line])
	if line_n < img[0]-1:
		output += ","
	print(output)
	line_n += 1

print(""");
end package;""")
