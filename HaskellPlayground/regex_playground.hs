-- import Text.Regex.TDFA
-- import Text.Regex.TDFA.Text ()
import Text.Regex.Posix

{- title - /en/
 - "/en/salvador-dali/untitled-figures-pieta-catastrophic-signs"
 -
 -}

titleRegex = "(href=\\/[a-z1-9-]*)"
--fxx = "I, B. Ionsonii, uurit a lift'd batch" =~ "(l[a-z]*'d|quux)" :: String
-- fxx'' = "<a href=/this-is-a-title" =~ "(\\/[a-z1-9-]*)" :: String

rgxCustom :: String -> String -> String
rgxCustom _s _rgx = _s =~ _rgx

rgxTitle :: String -> String
rgxTitle _a = _a =~ rgx
  where rgx = "(\\/[a-z1-9-]*)"


rgx2 :: String -> String
rgx2 _a = _a =~ rgx
  where rgx = "(\"\\/[a-z1-9-]*\")"

xxf2 = "<a dsffds  href=\"/the-obscured-fart\""

xxf = [ 
  "<a adnjdksj href=/the-whispering-eye", "<a dsffds  href=/the-obscured-fart",
  "<a  sdfsdf sfd href=/this-is-not-art", "<a sfd sdf href=/dirty-sanchezd",
  "<a sd sfd  href=/white-knuckler"]

regThatList = rgxTitle <$> xxf 

regThatListCustom =  [rgxCustom ij titleRegex | ij <- xxf]

main :: IO ()
main = do
  putStrLn "\n  regex playground \n"

  let reg00 = rgxTitle "<a href=/hello-world"
  putStrLn reg00

  let reg01 = rgxCustom "<a href=/custom-regex-title" titleRegex
  print reg01

  let t1 = rgx2 xxf2
  print $ t1

  print $ regThatList
  putStrLn "\n"
  print $ regThatListCustom

  putStrLn xxf2
