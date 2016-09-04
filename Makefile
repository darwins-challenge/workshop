.PHONY: clean

workshop.tar.gz: moonlander-game
	tar cvfz workshop.tar.gz moonlander-game

clean:
	rm -f workshop.tar.gz
