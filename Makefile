.PHONY: clean, book

build_dir = build
archive = workshop.tar.gz
files = moonlander-game moonlander-ast-rust moonlander-visualisation

$(build_dir)/$(archive): $(build_dir) $(files) book
	tar cvfz $(build_dir)/$(archive) $(files)

$(build_dir):
	mkdir -p $(build_dir)

clean:
	rm -rf $(build_dir)

book:
	curl -L -X GET "https://leanpub.com/s/$(BOOK_ID)?api_key=$(LEANPUB_API_KEY)" > $(build_dir)/flymetothemoon.pdf
