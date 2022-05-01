-- Übungsblatt 4
------------------------------------------------------------------------
-- Aufgabe 2

foldleft :: (Int -> Int -> Int) -> Int -> [Int] -> Int
foldleft f x []     = x
foldleft f x (y:ys) = foldleft f (f x y) ys

-- Die Funktion foldleft ist in der Haskell-Standardbibliothek
-- unter dem Namen foldl implementiert.