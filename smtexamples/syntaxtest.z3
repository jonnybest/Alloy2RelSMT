(declare-sort a)
(declare-sort b)
(declare-fun a1 () a)
(declare-fun b1 () b)
(declare-fun do (a b) Bool)
(declare-fun dont (a) Bool)
(assert
  (and (do a1 b1) false)
)
(assert
  (not (dont a1))
)
(check-sat)
(exit)