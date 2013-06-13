install:
	@ghc main.hs -o play
	@echo "Done."

clean:
	@rm *.hi
	@rm *.o
	@rm play

test:
	@runhaskell Spec.hs
