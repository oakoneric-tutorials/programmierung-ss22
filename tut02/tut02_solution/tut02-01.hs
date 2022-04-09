-- Aufgabe 1
------------------------------------------------------------------------

-- (a) Umkehrung einer Liste
rev :: [Int] -> [Int]
rev [] = []
rev (x:xs) = rev xs ++ [x]
-- mit ++ können Listen zusammengeführt werden

------------------------------------------------------------------------

-- (b) Sortierung prüfen
isOrd :: [Int] -> Bool
isOrd [] = True
isOrd [x] = True
isOrd (x:y:xs)
  | x <= y = isOrd (y:xs)
  | otherwise = False

-- oder besser:
isOrd' :: [Int] -> Bool
isOrd' [] = True
isOrd' [x] = True
isOrd' (x:y:xs) = x <= y && isOrd' (y:xs)

------------------------------------------------------------------------

-- (c) sortiertes Zusammenfügen zweier Listen
merge :: [Int] -> [Int] -> [Int]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x < y = x : merge xs (y:ys)
  | otherwise = y : merge (x:xs) ys

-- oder:
merge' :: [Int] -> [Int] -> [Int]
merge' [] ys = ys
merge' xs [] = xs
merge' xxs@(x:xs) yys@(y:ys)
  | x < y = x : merge' xs yys
  | otherwise = y : merge' xxs ys

------------------------------------------------------------------------

-- (d) Fibonacci-Liste
fib :: Int -> Int
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

fib' :: Int -> Int
fib' i = stack 1 1 i
    where stack f0 f1 0 = f0
          stack f0 f1 i = stack f1 (f0 + f1) (i-1)


fibs :: [Int] -- Standardvariante
fibs = fibAppend 0
  where
    fibAppend x = fib x : fibAppend (x+1)

fibs' :: [Int] -- mit iterativer Berechnung
fibs' = fibAppend 0
  where
    fibAppend x = fib' x : fibAppend (x+1)

fibs'' :: [Int] -- integrierte iterative Variante
fibs'' = fibs''' 0 1
  where
    fibs''' n m = n : fibs''' m (n+m)

-- take 7 fibs liefert die ersten 7 Fibonacci-Zahlen
-- interessant sind insbesondere die Werte größer als 30