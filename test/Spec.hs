import Test.Hspec
import Lib

main :: IO ()
main = hspec $ do
  describe "reveal" $ do
    it "reveals all matching chars (ignoring case) in the output" $
      reveal "Martin" "Natalie" `shouldBe` "_a_tin"
   
  describe "merge" $ do
    it "overwrites all non alphabetical chars in `a` with contents of `b`" $
      merge "______" "_a_ti_" `shouldBe` "_a_ti_"

    it "maintains all alphabetical chars" $
      merge "_a_ti_" "M_____" `shouldBe` "Ma_ti_"

