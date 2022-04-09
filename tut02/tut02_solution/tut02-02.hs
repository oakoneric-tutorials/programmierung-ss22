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