.PHONY: clean

build_dir = build
archive = workshop.tar.gz
files = moonlander-game moonlander-ast-rust moonlander-visualisation

$(build_dir)/$(archive): $(build_dir) $(files)
	tar cvfz $(build_dir)/$(archive) $(files)

$(build_dir):
	mkdir -p $(build_dir)

clean:
	rm -rf $(build_dir)
