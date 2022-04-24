-- Übungsblatt 3
------------------------------------------------------------------------
-- Aufgabe 1

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
-- Aufgabe 2

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

-- (d) Levelorder-Traversierung
unwind :: BinTree -> [Int]
unwind t = go [t]
    where
        go []                  = []
        go (Nil            : ts) = go ts
        go ((Branch n l r) : ts) = n : go (ts ++ [l,r])

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

-- (d) Liste rotieren
rotate :: [Int] -> Int -> [Int]
rotate [] _ = []
rotate xss@(x:xs) n
  | n == 0    = xss
  | n < 0     = rotate xss (length xss + n)
  | otherwise = rotate (xs ++ [x]) (n - 1)