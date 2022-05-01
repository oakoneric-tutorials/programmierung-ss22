-- Übungsblatt 4
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