-- Aufgabe 1

bincoeff :: Int -> Int -> Int
bincoeff n k = fac n ‘div‘ (fac (n-k) * fac k)
    where
        fac n
            | n < 1 = 1
            | otherwise = n * fac (n-1)