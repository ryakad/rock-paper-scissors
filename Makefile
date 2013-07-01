all: Main

Main: RockPaperScissors
	@ghc -c Main.hs -o play

RockPaperScissors:
	@ghc -c RockPaperScissors.hs

clean:
	@rm *.hi
	@rm *.o
	@rm play

test:
	@runhaskell Spec.hs
