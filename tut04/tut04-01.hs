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