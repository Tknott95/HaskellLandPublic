import Text.Read (readMaybe)

lorem ::  String -> String -> String -> Maybe Int
lorem i j k = case readMaybe i of
  Nothing -> Nothing
  Just x -> case readMaybe j of
    Nothing -> Nothing
    Just y -> case readMaybe k of
      Nothing -> Nothing
      Just z -> Just (x+y+z)

bindMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b
bindMaybe Nothing _ = Nothing
bindMaybe (Just x) f = f x

lorem_v2 :: String -> String -> String -> Maybe Int
lorem_v2 i j k = 
  readMaybe i `bindMaybe` \x ->
  readMaybe j `bindMaybe` \y ->
  readMaybe k `bindMaybe` \z ->
  Just (x+y+z)


readEither ::  Read a => String -> Either String a
readEither thisString = case readMaybe thisString of
  Nothing -> Left $ "CAN'T PARSE: " ++ thisString
  Just a  -> Right a

{- Look at changes compared to lorem -}
lorem_v3 :: String -> String -> String -> Either String Int
lorem_v3 i j k =
  case readEither i of
    Left err -> Left err
    Right x -> case readEither j of
      Left err -> Left err
      Right y -> case readEither k of
        Left err -> Left err
        Right z -> Right (x+y+z)


bindEither :: Either String a -> (a -> Either String b) -> Either String b
bindEither (Left err) _ = Left err
bindEither (Right i) f = f i


lorem_v4 :: String -> String -> String -> Either String Int
lorem_v4 i j k =
  readEither i `bindEither` \x ->
  readEither j `bindEither` \y ->
  readEither k `bindEither` \z ->
  Right (x+y+z)
  
