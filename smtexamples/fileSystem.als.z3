(set-logic UFBV)
(set-option :macro-finder true)
;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)
;; --end sorts

;; functions
(declare-fun subset_1 (Rel1 Rel1) Bool)
(declare-fun entries () Rel2)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun parent () Rel2)
(declare-fun lone_1 (Rel1) Bool)
(declare-fun one_1 (Rel1) Bool)
(declare-fun some_1 (Rel1) Bool)
(declare-fun trans (Rel2) Bool)
(declare-fun transClos (Rel2) Rel2)
(declare-fun union_1 (Rel1 Rel1) Rel1)
(declare-fun diff_1 (Rel1 Rel1) Rel1)
(declare-fun File () Rel1)
(declare-fun Root () Rel1)
(declare-fun Dir () Rel1)
(declare-fun FSO () Rel1)
;; --end functions

;; assertions
(assert
  (forall ((x Rel1)(y Rel1)) (= (subset_1 x y) (forall ((a0 Atom)) (=> (in_1 a0 x) (in_1 a0 y)))))
)
(assert
  (subset_1 File FSO)
)
(assert
  (subset_1 Root Dir)
)
(assert
  (subset_1 Dir FSO)
)
(assert
  (forall ((A Rel1)(B Rel1)(x0 Atom)(y0 Atom)) (= (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B))))
)
(assert
  (forall ((x Rel2)(y Rel2)) (= (subset_2 x y) (forall ((a0 Atom)(a1 Atom)) (=> (in_2 a0 a1 x) (in_2 a0 a1 y)))))
)
(assert
  (subset_2 entries (prod_1x1 Dir FSO))
)
(assert
  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B)))))
)
(assert
  (forall ((x0 Atom)) (and (in_1 x0 (a2r_1 x0)) (forall ((y0 Atom)) (=> (in_1 y0 (a2r_1 x0)) (= x0 y0)))))
)
(assert
  (forall ((this Atom)) (=> (in_1 this FSO) (or (in_1 this File) (in_1 this Dir))))
)
(assert
  (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) (not (in_1 a0 B))))))
)
(assert
  (disjoint_1 File Dir)
)
(assert
  (subset_2 parent (prod_1x1 FSO Dir))
)
(assert
  (forall ((X Rel1)) (= (lone_1 X) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0)))))
)
(assert
  (forall ((this Atom)) (=> (in_1 this FSO) (lone_1 (join_1x2 (a2r_1 this) parent))))
)
(assert
  (forall ((X Rel1)) (= (one_1 X) (and (exists ((a0 Atom)) (in_1 a0 X)) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0))))))
)
(assert
  (forall ((A Rel1)) (= (some_1 A) (exists ((a0 Atom)) (in_1 a0 A))))
)
(assert
  (forall ((r Rel2)) (= (trans r) (forall ((a1 Atom)(a2 Atom)(a3 Atom)) (=> (and (in_2 a1 a2 r) (in_2 a2 a3 r)) (in_2 a1 a3 r)))))
)
(assert
  (forall ((r Rel2)) (subset_2 r (transClos r)))
)
(assert
  (forall ((r Rel2)) (trans (transClos r)))
)
(assert
  (forall ((r1 Rel2)(r2 Rel2)) (=> (and (subset_2 r1 r2) (trans r2)) (subset_2 (transClos r1) r2)))
)
(assert
  (forall ((x0 Atom)(A Rel1)(B Rel1)) (= (in_1 x0 (union_1 A B)) (or (in_1 x0 A) (in_1 x0 B))))
)
(assert
  (and 
    (one_1 Root)
    (not (some_1 (join_1x2 Root parent)))
    (= FSO (union_1 Root (join_1x2 Root (transClos entries))))
    (forall ((o Atom)(d Atom)) (=> (and (in_1 o FSO) (in_1 d Dir)) (=> (in_1 o (join_1x2 (a2r_1 d) entries)) (= (join_1x2 (a2r_1 o) parent) (a2r_1 d)))))
  )
)
(assert
  (forall ((A Rel1)(B Rel1)(a0 Atom)) (= (in_1 a0 (diff_1 A B)) (and (in_1 a0 A) (not (in_1 a0 B)))))
)
(assert
  (not (forall ((o Atom)) (=> (and (in_1 o FSO) (in_1 o (diff_1 FSO Root))) (one_1 (join_1x2 (a2r_1 o) parent)))))
)
;; --end assertions

;; lemmas
(assert
  ; 1. lemma for join_1x2. direction: join to in
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)) (in_2 a1 a0 r)))
)
(assert
  ; 2. lemma for join_1x2. direction: in to join
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_2 a1 a0 r) (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r))))
)
(assert
  (forall ((a1 Atom)(a2 Atom)(r Rel2)) (=> (in_2 a1 a2 (transClos r)) (exists ((a3 Atom)) (and (in_2 a1 a3 r) (in_2 a3 a2 (transClos r))))))
)
(assert
  (forall ((a1 Atom)(a2 Atom)(r Rel2)) (=> (in_2 a1 a2 (transClos r)) (exists ((a3 Atom)) (and (in_2 a1 a3 (transClos r)) (in_2 a3 a2 r)))))
)
;; --end lemmas

;; -- key stuff for debugging --
;\problem {(
;
;)-> (
;
;;\predicates {

;;}

;; -- END key stuff --
(check-sat)
