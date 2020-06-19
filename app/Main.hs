
module Main where

import System.Directory (doesPathExist)
import Lib
import Names (preset)
import Options
import Control.Monad (unless)

data MainOptions = MainOptions
    { optNames :: String }

instance Options MainOptions where
    defineOptions = pure MainOptions
        <*> simpleOption "names" ""
            "File with line separated names to use instead of the default ones."


main :: IO ()
main = runCommand $ \opts args -> do
    isPath <- doesPathExist (optNames opts)
    if (not isPath) then do 
        start preset
    else do
        c <- readFile (optNames opts)
        start (lines c)
