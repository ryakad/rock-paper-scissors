--
-- Haskell - Rock Paper Scissors
--
-- For the full copyright and license information, please view the LICENSE
-- file that was distributed with this source code.
--
-- Tests Cases
--
-- Author: Ryan Kadwell <ryan@riaka.ca>
--

import RockPaperScissors
import Test.HUnit

test1 = TestCase (assertEqual "Paper beats rock" (-1) (outcome Rock Paper))
test2 = TestCase (assertEqual "Rock beats scissors" 1 (outcome Rock Scissors))

tests = TestList [TestLabel "Test 1" test1, TestLabel "Test 2" test2]
