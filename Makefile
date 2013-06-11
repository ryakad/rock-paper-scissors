install:
	@ghc main.hs -o rps
	@echo "Done."

clean:
	@rm *.hi
	@rm *.o
	@rm rps
