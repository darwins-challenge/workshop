.PHONY: clean, book, docs

build_dir = build
archive = workshop.tar.gz
pdf = flymetothemoon.pdf
files = AGC bring-your-own moonlander-ast moonlander-game moonlander-gp moonlander-visualisation nadezhda presentation $(pdf) cargo_home README.md help doc
docs = README.html help/README.html help/FIRST_TIME_RUSTER.html help/STRAIGHT_HINTS.html help/TWISTED_HINTS.html \
	   moonlander-game/README.html \
	   moonlander-gp/README.html \
	   moonlander-ast/README.html \
	   moonlander-visualisation/README.html \
	   nadezhda/README.html

all: $(build_dir)/$(archive) docs doc

docs: $(docs)


$(build_dir)/$(archive): book $(build_dir) $(files)
	tar cvfz $(build_dir)/$(archive) $(files)

%.html: %.md $(CURDIR)/Makefile
	pandoc -s -S --toc -H $(CURDIR)/build/github-pandoc.html.inc $< -o $@

$(build_dir):
	mkdir -p $(build_dir)

cargo_home:
	mkdir -p cargo_home && build/fetch-deps

clean:
	rm -rf $(build_dir)

book:
	curl -L -X GET "https://leanpub.com/s/$(BOOK_ID)?api_key=$(LEANPUB_API_KEY)" -o $(pdf)

doc:
	build/create-docs
