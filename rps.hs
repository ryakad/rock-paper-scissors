--
-- Haskell - Rock Paper Scissors
--
-- For the full copyright and license information, please view the LICENSE
-- file that was distributed with this source code.
--
-- Simple Rock Paper Scissors game written in haskell
--
-- Author: Ryan Kadwell <ryan@riaka.ca>
--

import Prelude hiding (cycle)

data Move = Rock | Paper | Scissors
    deriving (Show, Eq)

type Tournament = ([Move], [Move])
type Strategy = [Move] -> Move

outcome :: Move -> Move -> Integer
outcome Rock Scissors = 1
outcome Scissors Paper = 1
outcome Paper Rock = 1
outcome a b 
    | a == b = 0
    | otherwise = (-1)

tournamentOutcome :: Tournament -> Integer
tournamentOutcome (x, y) = sum (zipWith outcome x y)

rock, paper, scissors :: Strategy
rock _ = Rock
paper _ = Paper
scissors _ = Scissors

cycle :: Strategy
cycle moves = case (length moves) `rem` 3 of
    0 -> Rock
    1 -> Paper
    2 -> Scissors

play :: Strategy -> IO ()
play strategy = playInteractive strategy ([], [])

playInteractive :: Strategy -> Tournament -> IO ()
playInteractive s t@(mine, yours) = 
    do 
        ch <- getChar
        if not (ch `elem` "RPSrps")
        then showResults t
        else do 
            let next = s yours
            putStrLn ("\nI played " ++ show next ++ " and you played " ++ show (convertMove ch) ++ ".")
            tellSingleOutcome next (convertMove ch)
            let yourMove = convertMove ch
            playInteractive s (next:mine, yourMove:yours)

tellSingleOutcome :: Move -> Move -> IO ()
tellSingleOutcome me you
    | result == 1 = putStrLn (show me ++ " wins.")
    | result == (-1) = putStrLn (show you ++ " win.s")
    | otherwise = putStrLn "Draw"
    where result = outcome me you

convertMove :: Char -> Move
convertMove x
    | x `elem` "Rr" = Rock
    | x `elem` "Pp" = Paper
    | x `elem` "Ss" = Scissors

showResults :: Tournament -> IO ()
showResults x 
    | tournamentOutcome x < 0 = putStrLn "You win."
    | tournamentOutcome x == 0 = putStrLn "Draw."
    | otherwise = putStrLn "I win."
