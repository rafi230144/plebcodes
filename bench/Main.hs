{-# LANGUAGE Haskell2010
  , LambdaCase
  , ScopedTypeVariables
  , TypeApplications
#-}

module Main
  ( main
  ) where


-- + Imports

-- ++ (internal)

import Solution
  ( solution )


-- _ Ought-to-be-library-function

{-# INLINE seqElems #-}
seqElems :: forall a b. [a] -> b -> b
seqElems = flip $ foldr seq


-- * Benchmark

{-# NOINLINE testCases #-} -- So that GHC can\'t statically perform any of the work meant to occur at runtime
testCases :: [(String, String)]
testCases =
  [ ("bab", "aba")
  , ("leetcode", "practice")
  , ("anagram", "mangaar")
  , (replicate 50000 'a', replicate 50000 'b')
  ]

main :: IO ()
main =
    let testCount = length testCases
        test = uncurry solution . (testCases !!) . (`rem` testCount)
    in  fmap test [0..10000 * testCount - 1]
            `seqElems` pure ()
