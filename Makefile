.PHONY: clean, book

build_dir = build
archive = workshop.tar.gz
pdf = flymetothemoon.pdf
files = AGC bring-your-own moonlander-ast moonlander-game moonlander-gp moonlander-visualisation nadezhda presentation $(pdf) cargo_home README.md

$(build_dir)/$(archive): book $(build_dir) $(files)
	tar cvfz $(build_dir)/$(archive) $(files)

$(build_dir):
	mkdir -p $(build_dir)

cargo_home:
	mkdir -p cargo_home && ./fetch-deps

clean:
	rm -rf $(build_dir)

book:
	curl -L -X GET "https://leanpub.com/s/$(BOOK_ID)?api_key=$(LEANPUB_API_KEY)" > $(pdf)
