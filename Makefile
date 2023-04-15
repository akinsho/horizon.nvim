all:
	@nvim -l ./build/convert.lua
	@stylua ./lua/**/*.lua
	@echo "Generated ./lua/horizon/palette-*.lua files"
