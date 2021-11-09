module Domain.Score (
  mkScore,
  Score
) where

import Prelude
import Data.Either (Either(Right, Left))

type Point = Int
newtype Score = Score Point

mkScore :: Point -> Either String Score
mkScore point | 0 < point && point <= 3 = Right $ Score point
              | otherwise = Left "Score must be within 1..3"


instance Show Score where
  show (Score point) = "Score: " <> show point
