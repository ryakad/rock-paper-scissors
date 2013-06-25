all: Main

Main:
	@ghc Main.hs -o play

clean:
	@rm *.hi
	@rm *.o
	@rm play

test:
	@runhaskell Spec.hs
