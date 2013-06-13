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

module Main where

import RockPaperScissors
import System.IO
import GHC.IO.Handle

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    play beatLast
