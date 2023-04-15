all:
	nvim -l ./build/convert.lua
	stylua ./lua/**/*.lua
