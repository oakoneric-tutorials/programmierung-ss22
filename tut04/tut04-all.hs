-- Übungsblatt 4
------------------------------------------------------------------------
-- Aufgabe 1

f :: [Int] -> Int
f xs = foldr product 1 (map square (filter even' xs))
  where
    even' x = mod x 2 == 0
    square x = x * x
    product x y = x * y

f' :: [Int] -> Int
f' xs = foldr (*) 1 (map (^2) (filter even xs))

f'' :: [Int] -> Int
f'' = foldr (*) 1 . map (^2) . filter even

f''' :: [Int] -> Int
f''' = foldr (*) 1 . map (^2) . filter ((== 0) . (`mod` 2))

-- Hinweise: In Haskell werden Funktionen, die in Infix (also zwischen den
-- Argumenten, z.B. +, -, /, ==, &&) benutzt werden, in Klammern notiert
-- (z.B. (+) :: Int -> Int -> Int). D.h. Operatoren werden wie alle anderen
-- Funktionen behandelt, wenn man sie klammert, z.B. in „(+) 2 1 == 3“. Andere
-- Funktionen können auch Infix benutzt werden, indem sie durch Backticks („`“)
-- umgeben werden, z.B. „5 `mod` 2 == 1“ statt „mod 5 2 == 1“. Mittels
-- partieller Applikation kann man bei Infixfunktionen einen Wert an den
-- zweiten (rechten) Operanden binden, so ist „`mod` 2“ beispielsweise eine
-- Funktion, die für alle Eingabewerte den Restbetrag der Division durch 2
-- berechnet. Der Operator „.“ ist die Funktionskomposition, also berechet
-- „(== 0) . (`mod` 2)“ zuerst den Restbetrag der Division durch 2 und testet
-- diesen Wert dann der Gleichheit mit 0. Die entstehende Funktion gibt also
-- genau für alle geraden Eingabewerte den Wert „True“ zurück.

------------------------------------------------------------------------
-- Aufgabe 2

foldleft :: (Int -> Int -> Int) -> Int -> [Int] -> Int
foldleft f x []     = x
foldleft f x (y:ys) = foldleft f (f x y) ys

-- Die Funktion foldleft ist in der Haskell-Standardbibliothek
-- unter dem Namen foldl implementiert.

------------------------------------------------------------------------
-- Aufgabe 3

-- (a)
mytree :: Tree Char
mytree = Node ’a’ [ 
           Node ’b’ [ Node ’c’ [], Node ’d’ [] ] ,
           Node ’e’ [ Node ’f’ [] ],
           Node ’g’ []
         ]

-- (b)
oddTree :: Tree a -> Bool
oddTree (Node _ []) = True
oddTree (Node _ ts) = oddTrees ts && (length ts ‘mod‘ 2 == 1)
  where 
    oddTrees :: [Tree a] -> Bool
    oddTrees []       = True
    oddTrees (t : ts) = oddTree t && oddTrees ts

-- (b) alternativ:
oddTree' :: Tree a -> Bool
oddTree' (Node _ []) = True
oddTree' (Node _ xs) = foldr ((&&) . oddTree') (odd (length xs)) xs

-- (c) ohne Prelude
preOrder :: Tree a -> [a]
preOrder (Node x ts) = x : preOrderTrees ts
  where
    preOrderTrees []       = []
    preOrderTrees (t : ts) = preOrder t ++ preOrderTrees ts

-- (c) mit Prelude
preOrder :: Tree a -> [a]
preOrder (Node x ts) = x : concatMap preOrder ts