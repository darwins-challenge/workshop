.PHONY: clean

build_dir = build
archive = workshop.tar.gz

$(build_dir)/$(archive): $(build_dir) moonlander-game
	tar cvfz $(build_dir)/$(archive) moonlander-game

$(build_dir):
	mkdir -p $(build_dir)

clean:
	rm -rf $(build_dir)
