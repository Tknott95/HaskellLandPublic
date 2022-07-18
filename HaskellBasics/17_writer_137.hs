{-
 - input:        lorem (num' 100) (num' 30) (num' 7)
 -         
 - output:       Writer 137 ["#: 100","#: 30","#: 7"]
-}

data Writer a = Writer a [String]
  deriving Show

num' :: Int -> Writer Int
num' a = Writer a $ ["#: " ++ show a]

tell' :: [String] -> Writer ()
tell' as = Writer () as


lorem :: Writer Int -> Writer Int -> Writer Int -> Writer Int
lorem (Writer a is) (Writer b js) (Writer c ks) =
  Writer (a+b+c) $ is++js++ks


lorem_v2 :: Writer Int -> Writer Int ->  Writer Int -> Writer Int
lorem_v2 (Writer a is) (Writer b js) (Writer c ks) =
  let
    v = a+b+c
    Writer _ zs = tell' ["Sum: " ++ show v]
  in
    Writer v $ is ++ js ++ ks ++ zs


bindWriter :: Writer a -> (a -> Writer b) -> Writer b
bindWriter (Writer a is) f =
  let Writer b js = f a
  in Writer b $ is ++ js


-- this will l8r be called from a >>= operator by using an instance
