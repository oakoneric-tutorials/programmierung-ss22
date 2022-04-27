-- Aufgabe 1
data BinTree a = Branch a (BinTree a) (BinTree a) | Leaf a deriving Show

-- Aufgabe 1 (a)
testTree :: BinTree Int
testTree = Branch 5
             (Leaf 1)
             (Branch 12
               (Branch 4
                 (Leaf 0)
                 (Leaf 0))
               (Branch 12
                 (Leaf 0)
                 (Leaf 1)))

-- Aufgabe 1 (b)
depth :: BinTree a -> Int
depth (Leaf   _    ) = 1
depth (Branch _ l r) = 1 + min (depth l) (depth r)
-- Hinweis: Die Funktion min ist in der Haskell-Standardbibliothek vorhanden.

-- Aufgabe 1 (c)
paths :: BinTree a -> BinTree [a]
paths = go []
  where
    go :: [a] -> BinTree a -> BinTree [a]
    go prefix (Leaf   x    ) = Leaf   (prefix ++ [x])
    go prefix (Branch x l r) = Branch (prefix ++ [x]) (go (prefix ++ [x]) l) (go (prefix ++ [x]) r)
-- oder:
-- go prefix (Leaf   x    ) = Leaf   (reverse (x:prefix))
-- go prefix (Branch x l r) = let prefix' = x:prefix
--                            in Branch (reverse prefix') (go (prefix') l) (go (prefix') r)

-- Aufgabe 1 (d)
tmap :: (a -> b) -> BinTree a -> BinTree b
tmap f (Leaf   x    ) = Leaf   (f x)
tmap f (Branch x l r) = Branch (f x) (tmap f l) (tmap f r)