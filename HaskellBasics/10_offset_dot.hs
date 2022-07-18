mI_1D = [[1, 2, 3, 2.5]]
mI = [[1, 2, 3, 2.5], [3, 2, 3, 2.5]]
mW = [[0.2,0.8,-0.5, 1.0], [0.5, -0.91, 0.26, -0.5], [-0.26, -0.27, 0.17, 0.87]]
mB = [2, 3, 0.5]

mI3 = [[1, 2, 3, 2.5], [2.0, 5.0, -1.0, 2.0], [-1.5, 2.7, 3.3, -0.8]]

mW_6neurons = [[0.2,0.8,-0.5, 1.0], [0.5, -0.91, 0.26, -0.5], [-0.26, -0.27, 0.17, 0.87], [0.2,0.8,-0.5, 1.0], [0.5, -0.91, 0.26, -0.5], [-0.26, -0.27, 0.17, 0.87]]
mB_6neurons = [2, 3, 0.5,2, 3, 0.5]

dotProd :: Num a => [a] -> [a] -> a -> a
dotProd xs ys z = sum[x*y | (x,y) <- zip xs ys] + z

transpose:: [[a]]->[[a]]
transpose ([]:_) = []
transpose x = (map head x) : transpose (map tail x)

matDot :: Num a => [[a]] -> [[a]] -> [a] -> [[a]]
matDot inputs weights bs = [[dotProd i w b|  i <- inputs] | (w, b) <- zip weights bs]

-- @TODO I NEED TO TRANSPOSE MY WEIGHT ARRAY BEFORE APLYING DOT PROD
-- otherwise, everything else is working

-- on first input the return val is [] instead of [[]] like I had to add for now, I need to fix this
-- I wil prob make another func and then call this regarding what length is so the return isn't polymorphic which isn't working
-- matDot :: Num a => [[a]] -> [[a]] -> [a] ->  Either [a] [[a]]
-- matDot inputs weights bs
--   | length (head inputs) < 1 = Left [dotProd i w b |  i <- inputs, (w, b) <- zip weights bs]
--   | otherwise = Right [[dotProd i w b|  i <- inputs] | (w, b) <- zip weights bs]

main = do
  -- transposing after
  let d2 = transpose (matDot mI3 mW mB)

  putStrLn "\n -- matProd -- "
  print $  d2
  -- polymoorhic types are throwing errors every time I fic it with another !! 0
  -- if null (head d2)
  --   then print $ concat d2
  -- else print $ d2


-- OUTPUT b4 I ADD TRANSPOSE: [[4.8,8.9,1.4100000000000001],[1.21,-1.8099999999999996,1.0509999999999997],[2.385,0.19999999999999996,2.5999999999999912e-2]]
-- EXAMPLE OUTPUT I WANT [[4.8, 1.21, 2.385], [8.9, -1.81, 0.2], [1.41, 1.051, 0.026]]