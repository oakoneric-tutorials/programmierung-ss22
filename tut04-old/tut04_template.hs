-- Aufgabe 1
data BinTree a = Branch a (BinTree a) (BinTree a) | Leaf a deriving Show


-- Aufgabe 1 (a)
testTree :: BinTree Int
testTree = 

-- Aufgabe 1 (b)
depth :: BinTree a -> Int
depth  = 
depth  = 
-- Hinweis: Die Funktion min ist in der Haskell-Standardbibliothek vorhanden.

-- Aufgabe 1 (c)
paths :: BinTree a -> BinTree [a]
paths = 
  where
    

-- Aufgabe 1 (d)
tmap :: (a -> b) -> BinTree a -> BinTree b
tmap   = 
tmap   = 
