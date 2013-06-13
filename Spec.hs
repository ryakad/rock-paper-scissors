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

        it "beatlast knows what to play to beat rock" $ do
            beatLast [Rock, Paper, Scissors] `shouldBe` Paper

        it "beatlast knows what to play to beat paper" $ do
            beatLast [Paper, Rock, Scissors] `shouldBe` Scissors

        it "beatlast knows what to play to beat scissors" $ do
            beatLast [Scissors, Rock, Paper] `shouldBe` Rock

        it "converts r and R to Rock" $ do
            convertMove 'r' `shouldBe` Rock
            convertMove 'R' `shouldBe` Rock

        it "converts p and P to Paper" $ do
            convertMove 'p' `shouldBe` Paper
            convertMove 'P' `shouldBe` Paper

        it "converts s and S to Scissors" $ do
            convertMove 's' `shouldBe` Scissors
            convertMove 'S' `shouldBe` Scissors
