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

module Main (main) where

import RockPaperScissors (play, beatLast)
import System.IO
import GHC.IO.Handle

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    displayStartupMsg
    play beatLast

displayStartupMsg :: IO ()
displayStartupMsg = do
    putStrLn "\nRock Paper Scissors"
    putStrLn "To Play: enter r for Rock, p for Paper or s for Scissors\n"
