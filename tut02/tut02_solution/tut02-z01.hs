-- Zusatzaufgabe 1

-- (a) Buchstaben verpacken
pack :: [Char] -> [[Char]]
pack [] = []
pack (x:xs) = ys : pack zs
  where
    (ys, zs) = takeall x (x:xs)
    takeall _ [] = ([], [])
    takeall x (y:ys)
      | x == y = let (us, vs) = takeall x ys
                 in  (y:us, vs)
      | otherwise = ([], (y:ys))

-- (b) Lauflängenkodierung einer Buchstabenliste
encode :: [Char] -> [(Int, Char)]
encode xs = e' (pack xs)
  where e' [] = []
        e' (y:ys) = (head y, length y) : e' ys

-- (c) Lauflängendekodierung einer Buchstabenliste
decode ::  [(Int, Char)] -> [Char]
decode [] = []
decode ((n, x) : xs) = times n x : decode xs
  where
    times 0 x = []
    times n x = x : times (n-1) x

-- Zusatzaufgabe 1 (d)
rotate :: [Int] -> Int -> [Int]
rotate [] _ = []
rotate xss@(x:xs) n
  | n == 0    = xss
  | n < 0     = rotate xss (length xss + n)
  | otherwise = rotate (xs ++ [x]) (n - 1)