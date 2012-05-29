;; functions
(declare-fun contents () Rel2)
(declare-fun join_1x2 () Bool)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun one_1 (Rel1) Bool)
(declare-fun join_2x1 () Bool)
(declare-fun Dir () Rel1)
(declare-fun File () Rel1)
(declare-fun Root () Rel1)
(declare-fun Object () Rel1)
;; --end functions

;; assertions
(assert
  (subset_1 Dir Object)
)
(assert
  (subset_2 contents (prod_1x1 Dir Object))
)
(assert
  (forall ((x Atom)) (and (in_1 x (a2r_1 x)) (forall ((y Atom)) (=> (in_1 y (a2r_1 x)) (= x y)))))
)
(assert
  true
)
(assert
  (subset_1 File Object)
)
(assert
  (subset_1 Root Dir)
)
(assert
  (one_1 Root)
)
(assert
  (forall ((this Atom)) (=> (in_1 this Object) (or (in_1 this Dir) (in_1 this File))))
)
(assert
  (disjoint_1 Dir File)
)
(assert
  (subset_1 Object (join_1x2 Root (reflTransClos contents)))
)
(assert
  (not (and (subset_1 Object (join_1x2 Root (reflTransClos contents))) (not (forall ((o Atom)) (=> (and (in_1 o Object) (in_1 o (diff_1 Object Root))) (some_1 (join_2x1 contents (a2r_1 o))))))))
)
(assert
  (not (and (subset_1 Object (join_1x2 Root (reflTransClos contents))) (not (forall ((f Atom)) (=> (in_1 f File) (some_1 (join_2x1 contents (a2r_1 f))))))))
)
;; --end assertions

;; -- key stuff for debugging --
;\problem {(
;
;)-> (
;
;;\predicates {

;;}

;; -- END key stuff --
(check-sat)
