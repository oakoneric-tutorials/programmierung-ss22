cnext :: Int -> Int
cnext n
    | n `mod` 2 == 0 = n `div` 2
    | otherwise      = 3 * n + 1

ck :: Int -> Int
ck 1 = 1
ck n = 1 + ck (cnext n)

cmax :: Int -> Int
cmax 0 = 0
cmax n = max (cmax (n-1)) (ck n) -- oder cmax (n-1) ‘max‘ ck n
    where max a b
        | a > b     = a
        | otherwise = b

collatz :: Int -> [Int]
collatz 1 = [1]
collatz n = n : collatz (cnext n)