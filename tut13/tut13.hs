--    i     sum
f :: Int -> Int -> Int
f x1 x2 = if x1 == 0 
          then x2
          else if x1 `mod` 2 == 0
               then f (x1 - 1) (x2 + x1)
               else f (x1 - 1) (x2 - x1)

