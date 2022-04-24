data BinTree = Branch Int BinTree BinTree | Nil deriving Show

mytree :: BinTree
mytree = Branch 0 
            Nil 
            (Branch 3 
                (Branch 1 Nil Nil)
                (Branch 5 Nil Nil)
            )

equal :: BinTree -> BinTree -> Bool 
equal Nil Nil = True
equal Nil (Branch y l r) = False
equal (Branch x l r) Nil = False
equal (Branch x l1 r1) (Branch y l2 r2)
    = (x == y) && (equal l1 l2) && (equal r1 r2)