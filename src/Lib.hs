module Lib
    ( 
        start,
        guess,
        next,
        reveal,
        merge
    ) where

import System.Random (randomR, getStdRandom)
import Data.Char (isLetter, toLower)

reveal :: String -> String -> String
reveal name guess 
    = map (\x -> if (toLower x) `elem` (lowercase guess) then x else '_') name


merge :: String -> String -> String
merge a b = [if isLetter x 
            then x 
            else y | (x,y) <- zip a b]

lowercase :: String -> String
lowercase = map toLower

next :: String -> String -> Int -> IO ()
next name current attempts = 
    do 
        if current == name then putStrLn "The devil told you that!" 
        else if attempts==0 then putStrLn "Now give me what you promised."
        else guess name current attempts

guess :: String -> String -> Int -> IO ()
guess name current attempts =
    do 
        putStrLn ("Tonight tonight, my plans I make, tomorrow tomorrow, the baby I take. You will never win the game, for " ++  current ++ " is my name.")
        putStrLn "Now, what is my name?"
        g <- getLine
        let current' = merge current (reveal name g)      
        next name current' (attempts -1)

start :: [String] -> IO ()
start names = 
    do  
        i <- getStdRandom (randomR (0, (length names) -1))
        let name = (names !! i)
        next name ['_' | _ <- name] 9