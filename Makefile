install:
	@ghc main.hs -o rps
	@echo "Done."

uninstall:
	@rm *.hi
	@rm *.o
	@rm rps
