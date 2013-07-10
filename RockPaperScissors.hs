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

module RockPaperScissors where
import Prelude hiding (cycle)
import System.IO
import GHC.IO.Handle

data Move = Rock | Paper | Scissors
    deriving (Show, Eq)

type Tournament = ([Move], [Move])
type Strategy = [Move] -> Move

outcome :: Move -> Move -> Int
outcome Rock Scissors = 1
outcome Scissors Paper = 1
outcome Paper Rock = 1
outcome a b
    | a == b = 0
    | otherwise = (-1)

tournamentOutcome :: Tournament -> Int
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

beat :: Move -> Move
beat Paper = Scissors
beat Rock = Paper
beat Scissors = Rock

-- If the user's last two moves are the same assume that they are playing
-- a constant strategy and play to beat that. Requires a default strategy if
-- to play if the last two moves are not the same.
beatLast :: Strategy
beatLast [] = Rock
beatLast (x : xs) = beat x

-- Function for returning a random strategy when fed a random number
getRandomStrategy :: Int -> Strategy
getRandomStrategy x = case x of
    1 -> paper
    2 -> rock
    3 -> scissors
    4 -> cycle
    5 -> beatLast

play :: Strategy -> IO ()
play strategy = playInteractive strategy ([], [])

playInteractive :: Strategy -> Tournament -> IO ()
playInteractive s t@(mine, yours) =
    do
        hSetBuffering stdout NoBuffering
        putStr "choose your move: "
        ch <- getChar
        if not (ch `elem` "RPSrps")
        then showResults t
        else do
            let next = s yours
            putStr "\n"
            tellSingleOutcome next (convertMove ch)
            putStrLn (" - Computer played " ++ show next ++ " and you played " ++ show (convertMove ch) ++ ".")
            let yourMove = convertMove ch
            playInteractive s (next:mine, yourMove:yours)

tellSingleOutcome :: Move -> Move -> IO ()
tellSingleOutcome me you
    | result == 1 = putStr (show me ++ " wins.")
    | result == (-1) = putStr (show you ++ " win.")
    | otherwise = putStr "Draw"
    where result = outcome me you

convertMove :: Char -> Move
convertMove x
    | x `elem` "Rr" = Rock
    | x `elem` "Pp" = Paper
    | x `elem` "Ss" = Scissors

showResults :: Tournament -> IO ()
showResults (player1, player2) = do
    putStrLn "\nTournament Outcome\n=================="
    printWinner (player1, player2)
    putStrLn ("Total Games Played: " ++ show (tournamentLength (player1, player2)))
    putStrLn ("You Win: " ++ show (totalWins player2 player1))
    putStrLn ("Computer Wins: " ++ show (totalWins player1 player2))
    putStrLn ("Draws: " ++ show (tournamentLength (player1, player2) - (totalWins player1 player2) - (totalWins player2 player1)))

printWinner :: Tournament -> IO ()
printWinner x
    | tournamentOutcome x < 0 = putStrLn "You win."
    | tournamentOutcome x == 0 = putStrLn "Draw."
    | otherwise = putStrLn "Computer wins."

tournamentLength :: Tournament -> Int
tournamentLength (mine, _) = length mine

totalWins :: [Move] -> [Move] -> Int
totalWins [] _ = 0
totalWins _ [] = 0
totalWins (x:player1) (y:player2)
    | outcome x y == 1 = 1 + totalWins player1 player2
    | otherwise = totalWins player1 player2
