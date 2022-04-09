-- Aufgabe 1
-- cons Operator ":" trennt head und tail einer Liste
-- mit ++ können Listen zusammengeführt werden

------------------------------------------------------------------------

-- (a) Umkehrung einer Liste
rev :: [Int] -> [Int]


------------------------------------------------------------------------

-- (b) Sortierung prüfen
isOrd :: [Int] -> Bool


------------------------------------------------------------------------

-- (c) sortiertes Zusammenfügen zweier Listen
merge :: [Int] -> [Int] -> [Int]


------------------------------------------------------------------------

-- (d) Fibonacci-Liste
fib :: Int -> Int
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

fib' :: Int -> Int
fib' i = stack 1 1 i
    where stack f0 f1 0 = f0
          stack f0 f1 i = stack f1 (f0 + f1) (i-1)


fibs :: [Int]


fibs' :: [Int]


fibs'' :: [Int]


-- take 7 fibs liefert die ersten 7 Fibonacci-Zahlen
-- interessant sind insbesondere die Werte größer als 30