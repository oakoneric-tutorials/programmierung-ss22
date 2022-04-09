-- Übungsblatt 2

-- Aufgabe 1

-- (a) Umkehrung einer Liste
rev :: [Int] -> [Int]
rev [] = []
rev (x:xs) = rev xs ++ [x]
-- mit ++ können Listen zusammengeführt werden


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

------------------------------------------------------------------------

-- Aufgabe 2

-- (a) Präfix-Test
isPrefix :: String -> String -> Bool
isPrefix [] _ = True
isPrefix _ [] = False
isPrefix (p:ps) (c:cs) = p == c && isPrefix ps cs

-- (b) Vorkommen zählen
countPattern :: String -> String -> Int
countPattern "" "" = 1
countPattern _  "" = 0
countPattern xs yys@(y:ys)
    | isPrefix xs yys = 1 + countPattern xs ys
    | otherwise       = countPattern xs ys

------------------------------------------------------------------------

-- Aufgabe 3

data BinTree = Branch Int BinTree BinTree | Nil deriving (Show)

-- (a) Beispielbaum
mytree :: BinTree
mytree = Branch 0 
         ( Nil )
         ( Branch 3 
           ( Branch 1 Nil Nil )
           ( Branch 5 Nil Nil )
         )

-- (b) Test auf Baum-Gleichheit
equal :: BinTree -> BinTree -> Bool
equal Nil              Nil              = True
equal Nil              (Branch y l2 r2) = False
equal (Branch x l1 r1) Nil              = False
equal (Branch x l1 r1) (Branch y l2 r2)
      = (x == y) && (equal l1 l2) && (equal r1 r2)

-- (c) Schlüssel einfügen
insert :: BinTree -> [Int] -> BinTree
insert t     [] = t
insert t (x:xs) = insert t' xs
  where
    t' = insertSingle t x
    insertSingle Nil            x = Branch x Nil Nil
    insertSingle (Branch y l r) x
      | x < y     = Branch y (insertSingle l x) r
      | otherwise = Branch y l                  (insertSingle r x)

------------------------------------------------------------------------

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

------------------------------------------------------------------------

-- Zusatzaufgabe 2 (Typdefinition von Aufgabe 3)

mytree :: BinTree
mytree = Branch 1 ( Branch 2 (Branch 7 Nil Nil) (Branch 6 Nil Nil) )  ( Branch 3 (Branch 5 Nil Nil) (Branch 4 Nil Nil) )

unwind :: BinTree -> [Int]
unwind t = go [t]
    where
        go []                  = []
        go ((Branch a Nil Nil) : ts) = a : go ts
        go ((Branch a  l   r ) : ts) = a : go (ts ++ [l,r])