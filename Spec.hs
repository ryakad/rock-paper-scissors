--
-- Haskell - Rock Paper Scissors
--
-- For the full copyright and license information, please view the LICENSE
-- file that was distributed with this source code.
--
-- Tests for RockPaperScissors
--
-- Author: Ryan Kadwell <ryan@riaka.ca>
--

import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)
import RockPaperScissors

main :: IO ()
main = hspec $ do
    describe "RockPaperScissors.hs" $ do
        it "rock beats scissors" $ do
            outcome Rock Scissors `shouldBe` (1 :: Int)
        it "scissors beats paper" $ do
            outcome Scissors Paper `shouldBe` (1 :: Int)
        it "paper beats rock" $ do
            outcome Paper Rock `shouldBe` (1 :: Int)
