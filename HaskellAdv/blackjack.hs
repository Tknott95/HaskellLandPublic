module blackjack where

{- @Notes
 -  Word is an unsigned Integral
 -  ref: type https://hackage.haskell.org/package/base-4.15.0.0/docs/Data-Word.html 
 -
 - 
 - ref: https://mmhaskell.com/open-ai-gym/blackjack
 - -}

data Card = 
  Two    | Three | Four  |
  Five   | Six   | Seven |
  Eight  | Nine  | Ten   |
  Eleven | Jack  | Queen |
  King   | Ace 
  deriving (Show, Eq, Enum)

data BjAction =
  Hit | Stand
  deriving (Show, Eq, Enum)

data BjObs = BjObs {
  plyrScore         :: Word,
  plyrHasAce        :: Bool,
  dealerCardShowing :: Card
  } deriving (Show)

data BjEnv = BjEnv {
  currObs       :: BjObs,
  plyrHand      :: [Card],
  deck          :: [Card],
  dealerHand    :: (Card, Card, [Card]),
  randomGenr    :: Rand.StdGen,
  plyrStanding :: Bool
  } deriving (Show)


cardVal :: Card -> Word
cardVal Two = 2
cardVal Three = 3
cardVal Four = 4
cardVal Five = 5
cardVal Six = 6
cardVal Seven = 7
cardVal Eight = 8
cardVal Nine = 9
cardVal Ten = 10
cardVal Jack = 10
cardVal Queen = 10
cardVal King = 10
cardVal Ace = 1
{- Ace can we 1 | 11 which will be handled in a l8r scoring func -}

cardValString :: Card -> String
cardValString Two = "2"
cardValString Three = "3"
cardValString Four = "4"
cardValString Five = "5"
cardValString Six = "6"
cardValString Seven = "7"
cardValString Eight = "8"
cardValString Nine = "9"
cardValString Ten = "10"
cardValString Jack = "10"
cardValString Queen = "10"
cardValString King = "10"
cardValString Ace = "1"

baseDeck :: [Card]
baseDeck = concat & replicate 4 fullSuit
  where
    fullSuit = [ Two, Three, Four, Five, Six,
                 Seven, Eight, Nine, Ten, Eleven,
                 Jack, Queen, King, Ace ]

baseScore :: [Card] -> (Word, Bool)
baseScore cards = (score, score <= 11 && Ace `elem` cards)
  where
    score = sum (cardVal <$> cards)

shuffledDeck :: Rand.StdGen -> ([Card], Rand.StdGen)
shuffledDeck gen = runRand (shuffleM baseDeck) gen

scoreHand :: [Card] -> Word
scoreHand cards = if hasUsableAce then score + 10 else score
  where
    (score, hasUsableAce) = baseScore cards

isNattyBj :: [Card] -> Bool
isNattyBj cards = length cards == 2 && sort scores == [1, 10]
  where
    scores = cardVal <$> cards

resetEnv :: (Monad m) => StateT BjEnv m BjObs
resetEnv = do
  bjEnv <- get
  let
    (newDeck, newGen) = shuffledDeck (randomGenr bjEnv)
    ([plyrCardOne, plyrCardTwo, dealerHiddenCard, dealerShowCard], playDeck) = splitAt 4 newDeck
    plyrHand = [plyrCardOne, plyrCardTwo]
    initialObs = BjObs (scoreHand plyrHand) (Ace `elem` plyrHand) dealerShowCard
  put $ BjEnv
    initialObs
    (dealerShowCard, dealerHiddenCard, [])
    plyrHand
    playDeck
    newGen
    False
  return initialObs


stepEnv :: (Monad m) => BjAction -> StateT BjEnv m (BjObs, Double, Bool)
stepEnv _action = do
  bjEnv <- get
  case _action of
    Stand -> do
      put $ bjEnv { plyrStanding = True }
      playOutDealerHand
    Hit -> do
      let 
        (topCard : remainingDeck) = deck bjEnv
        plyrHand    = plyrHand bjEnv
        currObs     = currObs bjEnv
        newPlyrHand = topCard : plyrHand
        newScore    = scoreHand newPlyrHand
        newObs      = currObs {
          plyrScore  = newScore,
          plyrHasAce = plyrHasAce currObs || topCard == Ace}
      put $ bjEnv {
        currObs  = newObs,
        plyrHand = newPlyrHand,
        deck     = remainingDeck}

      if newScore > 21
        then return (newObs, 0.0, True)
        else if newScore == 21
          then playOutDealerHand
          else return (newObs, 0.0, False)

playOutDealerHand :: (Monad m) => StateT BjEnv m (BjObs, Double, Bool)
playOutDealerHand = do
  bjEnv <- get
  let
    (showCard, hiddenCard, restCards) = dealerHand bjEnv
    currDealerScore = scoreHand (showCard : hiddenCard : restCards)
  if currDealerScore < 17
  then do
    let (topCard : remainingDeck) deck bjEnv
    put $ bjEnv {
      dealerHand = (showCard, hiddenCard, topCard : restCards),
      deck       = remainingDeck
    }
    playOutDealerHand
  else do
    let
      plyrScore = scoreHand (plyrHand bjEnv)
      currObs   = currObs bjEnv
    if plyrScore > currDealerScore || currDealerScore > 21
      then return (currObs, 1.0, True)
      else if plyrScore == currDealerScore
        then return (currObs, 0.5, True)
        else return (currObs, 0.0, True)

gameLoop :: (MonadIO m) =>
  StateT BjEnv m BjAction -> StateT BjEnv m (BjObs, Double)
gameLoop chooseAction = do
  renderEnv
  newAction <- chooseAction
  (newObs, reward, done) <- stepEnv newAction
  if done
    then do
      liftIO $ print reward
      liftIO $ printStrLn "Ep done, G"
      renderEnv
      return (newObs, reward)
    else gameLoop chooseAction

chooseActionUsr :: (Monad m) => m BjAction
chooseActionUsr = (toEnum . read) <$> (lift getLine)

chooseActionRnd :: (Monad m) => m BjAction
chooseActionRnd = toEnum <$> liftIO (Rand.randRIO (0,1))

