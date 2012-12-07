; file: D:\Entwicklung\workspace\alloy2relsmt\smtexamples\marksweepgc_completeness.als 
; hash: 1BC8EB474FF88DA1CC704EC5723CACC9
(set-logic AUFLIA)
(set-option :macro-finder true)
;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)
(declare-sort Rel3)
;; --end sorts

;; functions
(declare-fun GC (Rel1 Rel1 Rel1) Bool)
(declare-fun HeapState () Rel1)
(declare-fun Node () Rel1)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun clearMarks (Rel1 Rel1) Bool)
(declare-fun diff_1 (Rel1 Rel1) Rel1)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun freeList () Rel2)
(declare-fun iden () Rel2)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun in_3 (Atom Atom Atom Rel3) Bool)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun join_1x3 (Rel1 Rel3) Rel2)
(declare-fun left () Rel3)
(declare-fun lone_1 (Rel1) Bool)
(declare-fun mark (Rel1 Rel1 Rel1) Bool)
(declare-fun marked () Rel2)
(declare-fun no_1 (Rel1) Bool)
(declare-fun none () Rel1)
(declare-fun one_1 (Rel1) Bool)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun prod_2x1 (Rel2 Rel1) Rel3)
(declare-fun reachable (Rel1 Rel1) Rel1)
(declare-fun right () Rel3)
(declare-fun setFreeList (Rel1 Rel1) Bool)
(declare-fun subset_1 (Rel1 Rel1) Bool)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun subset_3 (Rel3 Rel3) Bool)
(declare-fun trans (Rel2) Bool)
(declare-fun transClos (Rel2) Rel2)
(declare-fun union_1 (Rel1 Rel1) Rel1)
(declare-fun union_2 (Rel2 Rel2) Rel2)
;; --end functions

;; axioms
(assert 
 (! 
  ; axiom for union of Rel1
(forall ((x0 Atom)(A Rel1)(B Rel1)) (= (in_1 x0 (union_1 A B)) (or (in_1 x0 A) (in_1 x0 B)))) 
 :named axiom105b8187 
 ) 
 )
(assert 
 (! 
  ; this axiom defines transitivity
(forall ((r Rel2)) (= (trans r) (forall ((a1 Atom)(a2 Atom)(a3 Atom)) (=> (and (in_2 a1 a2 r) (in_2 a2 a3 r)) (in_2 a1 a3 r))))) 
 :named axiom11718914 
 ) 
 )
(assert 
 (! 
  (forall ((X Rel1)) (= (one_1 X) (and (exists ((a0 Atom)) (in_1 a0 X)) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0)))))) 
 :named axiom12f951fb 
 ) 
 )
(assert 
 (! 
  (forall ((y0 Atom)(x0 Atom)(A Rel1)(B Rel1)) (= (in_2 x0 y0 (prod_1x1 A B)) (and (in_1 x0 A) (in_1 y0 B)))) 
 :named axiom19bef732 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel2
(forall ((x Rel2)(y Rel2)) (= (subset_2 x y) (forall ((a0 Atom)(a1 Atom)) (=> (in_2 a0 a1 x) (in_2 a0 a1 y))))) 
 :named axiom225d0e51 
 ) 
 )
(assert 
 (! 
  ; this axioms satisfies that r should be in transclos of r
(forall ((r Rel2)) (subset_2 r (transClos r))) 
 :named axiom24c02eb3 
 ) 
 )
(assert 
 (! 
  ; (forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (=> (in_1 a0 A) (not (in_1 a0 B)))))); alternative
(forall ((A Rel1)(B Rel1)) (= (disjoint_1 A B) (forall ((a0 Atom)) (not (and (in_1 a0 A) (in_1 a0 B)))))) 
 :named axiom300ecb75 
 ) 
 )
(assert 
 (! 
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(R Rel1)) (=> (no_1 R) (not (in_1 a0 R)))) 
 :named axiom6282b3bb 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)(B Rel1)(a0 Atom)) (= (in_1 a0 (diff_1 A B)) (and (in_1 a0 A) (not (in_1 a0 B))))) 
 :named axiom63f656cf 
 ) 
 )
(assert 
 (! 
  ; axiom for empty set
(forall ((a Atom)) (not (in_1 a none))) 
 :named axiom6cf65805 
 ) 
 )
(assert 
 (! 
  (forall ((y0 Atom)(x0 Atom)(x1 Atom)(A Rel2)(B Rel1)) (= (in_3 x0 x1 y0 (prod_2x1 A B)) (and (in_2 x0 x1 A) (in_1 y0 B)))) 
 :named axiom6f1bf92f 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel1
(forall ((x Rel1)(y Rel1)) (= (subset_1 x y) (forall ((a0 Atom)) (=> (in_1 a0 x) (in_1 a0 y))))) 
 :named axiom76d2de83 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x3
(forall ((A Rel1)(B Rel3)(y0 Atom)(y1 Atom)) (= (in_2 y0 y1 (join_1x3 A B)) (exists ((x Atom)) (and (in_1 x A) (in_3 x y0 y1 B))))) 
 :named axiom82f21aba 
 ) 
 )
(assert 
 (! 
  ; this axiom satisfies minimality of transclos
(forall ((r1 Rel2)(r2 Rel2)) (=> (and (subset_2 r1 r2) (trans r2)) (subset_2 (transClos r1) r2))) 
 :named axioma79c8c27 
 ) 
 )
(assert 
 (! 
  (forall ((X Rel1)) (= (lone_1 X) (forall ((a0 Atom)(b0 Atom)) (=> (and (in_1 a0 X) (in_1 b0 X)) (= a0 b0))))) 
 :named axiomaa1ef80f 
 ) 
 )
(assert 
 (! 
  ; axiom for union of Rel2
(forall ((x0 Atom)(x1 Atom)(A Rel2)(B Rel2)) (= (in_2 x0 x1 (union_2 A B)) (or (in_2 x0 x1 A) (in_2 x0 x1 B)))) 
 :named axiomac2ef766 
 ) 
 )
(assert 
 (! 
  ; subset axiom for Rel3
(forall ((x Rel3)(y Rel3)) (= (subset_3 x y) (forall ((a0 Atom)(a1 Atom)(a2 Atom)) (=> (in_3 a0 a1 a2 x) (in_3 a0 a1 a2 y))))) 
 :named axiomb131cb24 
 ) 
 )
(assert 
 (! 
  (forall ((a0 Atom)) (in_2 a0 a0 iden)) 
 :named axiomb9cd35e2 
 ) 
 )
(assert 
 (! 
  ; axiom for join_1x2
(forall ((A Rel1)(B Rel2)(y0 Atom)) (= (in_1 y0 (join_1x2 A B)) (exists ((x Atom)) (and (in_1 x A) (in_2 x y0 B))))) 
 :named axiomc43ab575 
 ) 
 )
(assert 
 (! 
  ; axiom for the conversion function Atom -> Relation
(forall ((x0 Atom)) (and (in_1 x0 (a2r_1 x0)) (forall ((y0 Atom)) (=> (in_1 y0 (a2r_1 x0)) (= x0 y0))))) 
 :named axiome566b6fc 
 ) 
 )
(assert 
 (! 
  ; this axiom satisfies transitivity for transclos
(forall ((r Rel2)) (trans (transClos r))) 
 :named axiomeee40a91 
 ) 
 )
;; --end axioms

;; assertions
(assert 
 (! 
  (subset_2 freeList (prod_1x1 HeapState Node)) 
 :named assert3324d066 
 ) 
 )
(assert 
 (! 
  (subset_3 left (prod_2x1 (prod_1x1 HeapState Node) Node)) 
 :named assert38a92ef8 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this HeapState) (lone_1 (join_1x2 (a2r_1 this) freeList)))) 
 :named assert413932c7 
 ) 
 )
(assert 
 (! 
  (forall ((hs Rel1)(n Rel1)) (= (reachable hs n) (union_1 n (join_1x2 n (transClos (union_2 (join_1x3 hs left) (join_1x3 hs right))))))) 
 :named assert6077c345 
 ) 
 )
(assert 
 (! 
  (subset_2 marked (prod_1x1 HeapState Node)) 
 :named assert64c72364 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this HeapState) (and (forall ((x0 Atom)) (=> (in_1 x0 Node) (lone_1 (join_1x2 (a2r_1 x0) (join_1x3 (a2r_1 this) right))))) (forall ((x0 Atom)) (=> (in_1 x0 Node) (lone_1 (join_1x2 (a2r_1 x0) (join_1x3 (a2r_1 this) left)))))))) 
 :named assert6d2b630c 
 ) 
 )
(assert 
 (! 
  (subset_3 right (prod_2x1 (prod_1x1 HeapState Node) Node)) 
 :named asserta36e1ac7 
 ) 
 )
(assert 
 (! 
  (forall ((hs Rel1)(hs_ Rel1)) (= (setFreeList hs hs_) (and 
    (subset_1 (join_1x2 (join_1x2 hs_ freeList) (union_2 (transClos (join_1x3 hs_ left)) iden)) (diff_1 Node (join_1x2 hs marked)))
    (forall ((n Atom)) (=> (in_1 n Node) (ite (not (in_1 n (join_1x2 hs marked))) (and 
    (no_1 (join_1x2 (a2r_1 n) (join_1x3 hs_ right)))
    (subset_1 (join_1x2 (a2r_1 n) (join_1x3 hs_ left)) (join_1x2 (join_1x2 hs_ freeList) (union_2 (transClos (join_1x3 hs_ left)) iden)))
    (in_1 n (join_1x2 (join_1x2 hs_ freeList) (union_2 (transClos (join_1x3 hs_ left)) iden)))
  ) (and (= (join_1x2 (a2r_1 n) (join_1x3 hs_ left)) (join_1x2 (a2r_1 n) (join_1x3 hs left))) (= (join_1x2 (a2r_1 n) (join_1x3 hs_ right)) (join_1x2 (a2r_1 n) (join_1x3 hs right)))))))
    (= (join_1x2 hs_ marked) (join_1x2 hs marked))
  ))) 
 :named assertaf4ca2b0 
 ) 
 )
(assert 
 (! 
  (forall ((hs Rel1)(root Rel1)(hs_ Rel1)) (= (GC hs root hs_) (exists ((hs1 Atom)(hs2 Atom)) (and 
    (in_1 hs1 HeapState)
    (in_1 hs2 HeapState)
    (and 
    (clearMarks hs (a2r_1 hs1))
    (mark (a2r_1 hs1) root (a2r_1 hs2))
    (setFreeList (a2r_1 hs2) hs_)
  )
  )))) 
 :named assertb9402d6 
 ) 
 )
(assert 
 (! 
  (forall ((hs Rel1)(hs_ Rel1)) (= (clearMarks hs hs_) (and 
    (no_1 (join_1x2 hs_ marked))
    (= (join_1x3 hs_ left) (join_1x3 hs left))
    (= (join_1x3 hs_ right) (join_1x3 hs right))
  ))) 
 :named assertba3c7da5 
 ) 
 )
(assert 
 (! 
  (forall ((hs Rel1)(from Rel1)(hs_ Rel1)) (= (mark hs from hs_) (and 
    (= (join_1x2 hs_ marked) (reachable hs from))
    (= (join_1x3 hs_ left) (join_1x3 hs left))
    (= (join_1x3 hs_ right) (join_1x3 hs right))
  ))) 
 :named assertead86bd5 
 ) 
 )
(assert 
 (! 
  (disjoint_1 HeapState Node) 
 :named assertfdbe7c2 
 ) 
 )
;; --end assertions

;; command
(assert 
 (! 
  (not (forall ((h Atom)(h_ Atom)(root Atom)) (=> (and 
    (in_1 h HeapState)
    (in_1 h_ HeapState)
    (in_1 root Node)
  ) (=> (GC (a2r_1 h) (a2r_1 root) (a2r_1 h_)) (subset_1 (diff_1 Node (reachable (a2r_1 h_) (a2r_1 root))) (reachable (a2r_1 h_) (join_1x2 (a2r_1 h_) freeList))))))) 
 :named commandb897f30f 
 ) 
 )
;; --end command

;; lemmas
(assert
 (! 
  ; weak lemma 1 for transClos about the second-last 'middle element'
(forall ((a1 Atom)(a3 Atom)(R Rel2)) (=> (in_2 a1 a3 (transClos R)) (exists ((a2 Atom)) (in_2 a2 a3 R)))) 
 :named lemma6816308a 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_1x2. direction: in to join
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_2 a1 a0 r) (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)))) 
 :named lemma6ec6a62 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_1x3. direction: in to join
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel3)) (=> (in_3 a2 a1 a0 r) (in_2 a1 a0 (join_1x3 ; (swapped)
(a2r_1 a2) r)))) 
 :named lemma823ccdc0 
 ) 
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
