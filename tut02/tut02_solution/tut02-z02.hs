-- Zusatzaufgabe 2 
data BinTree = Branch Int BinTree BinTree | Nil deriving (Show) -- (Typdefinition von Aufgabe 3)

mytree :: BinTree
mytree = Branch 1 ( Branch 2 (Branch 7 Nil Nil) (Branch 6 Nil Nil) )  ( Branch 3 (Branch 5 Nil Nil) (Branch 4 Nil Nil) )

unwind :: BinTree -> [Int]
unwind t = go [t]
    where
        go []                  = []
        go ((Branch a Nil Nil) : ts) = a : go ts
        go ((Branch a l r)     : ts) = a : go (ts ++ [l,r])