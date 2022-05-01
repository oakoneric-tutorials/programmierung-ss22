data Tree a = Node a [Tree a] deriving Show

mytree :: Tree Char
mytree = Node 'a' [
            Node 'b' [Node 'c' [], Node 'd' []],
            Node 'e' [Node 'f' []],
            Node 'g' []
         ]

preOrder :: Tree a -> [a]
preOrder (Node x ts) = x : preOrderTrees ts
    where
        preOrderTrees :: [Tree a] -> [a]
        preOrderTrees []     = []
        preOrderTrees (t:ts) = preOrder t ++ preOrderTrees ts

preOrder' :: Tree a -> [a]
preOrder' (Node x ts) = x : concatMap preOrder' ts