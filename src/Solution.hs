{-# LANGUAGE Haskell2010
  , KindSignatures
  , ScopedTypeVariables
  , TypeApplications
#-}

{-# OPTIONS_GHC -Wall #-}

module Solution
  ( solution
  ) where


-- + Imports

-- ++ from base ^>= 4.21

import Data.Kind
  ( Type )

import Control.Monad.ST
  ( runST )

import Data.Foldable
  ( traverse_ )

-- ++ from primitive ^>= 0.9

import Control.Monad.Primitive
  ( PrimMonad
  , PrimState
  )

import Data.Primitive.Types
  ( Prim )

import Data.Primitive.PrimArray
  ( MutablePrimArray
  , writePrimArray
  , readPrimArray
  , unsafeThawPrimArray
  , unsafeFreezePrimArray
  , replicatePrimArray
  , primArrayToList
  )


-- _ Ought-to-be-library-functions

{-# INLINE modifyPrimArray #-}
modifyPrimArray :: forall (m :: Type -> Type) a.
    (PrimMonad m, Prim a) =>
    MutablePrimArray (PrimState m) a -> Int -> (a -> a) -> m ()
modifyPrimArray = \ wa i f -> do
    a <- readPrimArray wa i
    writePrimArray wa i $ f a

{-# INLINE alphPosLwr #-}
alphPosLwr :: Char -> Int
alphPosLwr = subtract 97 . fromEnum


-- * Solution

{-# INLINEABLE solution #-}
solution :: String -> String -> Int
solution = \ sx sy -> runST $ do
    wc <- unsafeThawPrimArray $ replicatePrimArray @Int 26 0
    traverse_ (\ c -> modifyPrimArray wc (alphPosLwr c) (+        1)) sx
    traverse_ (\ c -> modifyPrimArray wc (alphPosLwr c) (subtract 1)) sy
    sum . filter (> 0) . primArrayToList <$> unsafeFreezePrimArray wc
