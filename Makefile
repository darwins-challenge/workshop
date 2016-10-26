.PHONY: clean, book

build_dir = build
archive = workshop.tar.gz
pdf = flymetothemoon.pdf
files = moonlander-ast moonlander-game moonlander-gp moonlander-visualisation nadezhda presentation $(pdf)

$(build_dir)/$(archive): book $(build_dir) $(files)
	tar cvfz $(build_dir)/$(archive) $(files)

$(build_dir):
	mkdir -p $(build_dir)

clean:
	rm -rf $(build_dir)

book:
	curl -L -X GET "https://leanpub.com/s/$(BOOK_ID)?api_key=$(LEANPUB_API_KEY)" > $(pdf)
