; file: D:\Entwicklung\workspace\alloy2relsmt\smtexamples\fileSystem.als 
; hash: 97A5E31386 1FC91FF926F5019DB5D55
(set-logic AUFLIA)
(set-option :macro-finder true)
;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)
;; --end sorts

;; functions
(declare-fun Dir () Rel1)
(declare-fun FSO () Rel1)
(declare-fun File () Rel1)
(declare-fun Root () Rel1)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun a2r_2 (Atom Atom) Rel2)
(declare-fun diff_1 (Rel1 Rel1) Rel1)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun entries () Rel2)
(declare-fun iden () Rel2)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun join_2x1 (Rel2 Rel1) Rel1)
(declare-fun join_2x2 (Rel2 Rel2) Rel2)
(declare-fun lone_1 (Rel1) Bool)
(declare-fun no_1 (Rel1) Bool)
(declare-fun none () Rel1)
(declare-fun one_1 (Rel1) Bool)
(declare-fun parent () Rel2)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun subset_1 (Rel1 Rel1) Bool)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun trans (Rel2) Bool)
(declare-fun transClos (Rel2) Rel2)
(declare-fun transp (Rel2) Rel2)
(declare-fun union_2 (Rel2 Rel2) Rel2)
;; --end functions

;; axioms
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
  ; axiom for join_2x1
(forall ((A Rel2)(B Rel1)(y0 Atom)) (= (in_1 y0 (join_2x1 A B)) (exists ((x Atom)) (and (in_2 y0 x A) (in_1 x B))))) 
 :named axiom48f6aa73 
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
  ; subset axiom for Rel1
(forall ((x Rel1)(y Rel1)) (= (subset_1 x y) (forall ((a0 Atom)) (=> (in_1 a0 x) (in_1 a0 y))))) 
 :named axiom76d2de83 
 ) 
 )
(assert 
 (! 
  ; axiom for join_2x2
(forall ((A Rel2)(B Rel2)(y0 Atom)(y1 Atom)) (= (in_2 y0 y1 (join_2x2 A B)) (exists ((x Atom)) (and (in_2 y0 x A) (in_2 x y1 B))))) 
 :named axiom785d259e 
 ) 
 )
(assert 
 (! 
  ; axiom for the conversion function Atom -> Relation
(forall ((x0 Atom)(x1 Atom)) (and (in_2 x0 x1 (a2r_2 x0 x1)) (forall ((y0 Atom)(y1 Atom)) (=> (in_2 y0 y1 (a2r_2 x0 x1)) (and (= x0 y0) (= x1 y1)))))) 
 :named axiom7a8a4465 
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
  ; axiom for transposition
(forall ((a0 Atom)(a1 Atom)(R Rel2)) (= (in_2 a0 a1 (transp R)) (in_2 a1 a0 R))) 
 :named axiomedebf34b 
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
  (subset_1 Dir FSO) 
 :named assert17bac53e 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this FSO) (lone_1 (join_1x2 (a2r_1 this) parent)))) 
 :named assert19e4fea 
 ) 
 )
(assert 
 (! 
  (subset_1 File FSO) 
 :named assert3e626da7 
 ) 
 )
(assert 
 (! 
  (disjoint_1 File Dir) 
 :named assert55187156 
 ) 
 )
(assert 
 (! 
  (subset_2 entries (prod_1x1 Dir FSO)) 
 :named assert586585e6 
 ) 
 )
(assert 
 (! 
  (subset_1 Root Dir) 
 :named assert59298016 
 ) 
 )
(assert 
 (! 
  (and 
    (one_1 Root)
    (no_1 (join_1x2 Root parent))
    (= FSO (join_1x2 Root (union_2 (transClos entries) iden)))
    (forall ((o Atom)(d Atom)) (=> (and (in_1 o FSO) (in_1 d Dir)) (=> (in_1 o (join_1x2 (a2r_1 d) entries)) (= (join_1x2 (a2r_1 o) parent) (a2r_1 d)))))
    (= entries (transp parent))
  ) 
 :named assert65f6582c 
 ) 
 )
(assert 
 (! 
  (subset_2 parent (prod_1x1 FSO Dir)) 
 :named assert7051d726 
 ) 
 )
(assert 
 (! 
  (forall ((this Atom)) (=> (in_1 this FSO) (or (in_1 this File) (in_1 this Dir)))) 
 :named assertd4b9f50f 
 ) 
 )
;; --end assertions

;; command
(assert 
 (! 
  (not (forall ((o Atom)) (=> (and (in_1 o FSO) (in_1 o (diff_1 FSO Root))) (one_1 (join_1x2 (a2r_1 o) parent))))) 
 :named command2a7f5adc 
 ) 
 )
;; --end command

;; lemmas
(assert
 (! 
  ; lemma about subsets within joins, from com-theorem1, related to step 45
(forall ((a Rel1)(A Rel1)(B Rel1)(R Rel2)) (=> (subset_1 a A) (subset_1 (join_1x2 a R) (join_1x2 A R)))) 
 :named lemma1aecfc94 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_2x2. direction: in to join
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel2)) (=> (in_2 a1 a0 r) (in_2 a2 a0 (join_2x2 ; (swapped)
(a2r_2 a2 a1) r)))) 
 :named lemma3bc35ca3 
 ) 
 )
(assert
 (! 
  ; 2. lemma for join_2x1. direction: in to join
(forall ((a0 Atom)(a1 Atom)(r Rel2)) (=> (in_2 a0 a1 r) (in_1 a0 (join_2x1 r (a2r_1 a1))))) 
 :named lemma50960a04 
 ) 
 )
(assert
 (! 
  ; weak lemma 1 for transClos about the second-last 'middle element'
(forall ((a1 Atom)(a3 Atom)(R Rel2)) (=> (in_2 a1 a3 (transClos R)) (exists ((a2 Atom)) (in_2 a2 a3 R)))) 
 :named lemma6816308a 
 ) 
 )
(assert
 (! 
  ; equality Lemma (newly introduced. Be careful, this is very costly.
(forall ((x Rel1)(y Rel1)) (=> (= x y) (and (subset_1 x y) (subset_1 y x)))) 
 :named lemma68418934 
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
  ; weak lemma 2 for transClos about the second 'middle element'
(forall ((a1 Atom)(a3 Atom)(R Rel2)) (=> (in_2 a1 a3 (transClos R)) (or (in_2 a1 a3 R) (exists ((a2 Atom)) (and (in_2 a1 a2 R) (in_2 a2 a3 (transClos R))))))) 
 :named lemma78e4c8ed 
 ) 
 )
(assert
 (! 
  ; lemma for step 21 of the com-theorem1 for join_1x2: R=(i.qi) S=iids
(forall ((R Rel2)(S Rel2)(x Atom)) (=> (no_1 (join_1x2 (a2r_1 x) R)) (no_1 (join_1x2 (a2r_1 x) (join_2x2 R S))))) 
 :named lemma844803cd 
 ) 
 )
(assert
 (! 
  ; lstep20: lemma about subset 2 and product 1x1 , using join
(forall ((R Rel2)(A Rel1)(B Rel1)) (=> (subset_2 R (prod_1x1 A B)) (forall ((a0 Atom)) (= (not (in_1 a0 (join_2x1 R B))) (no_1 (join_1x2 (a2r_1 a0) R)))))) 
 :named lemma8f0bdd2 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_2x2. direction: join to in
(forall ((a2 Atom)(a1 Atom)(a0 Atom)(r Rel2)) (=> (in_2 a2 a0 (join_2x2 ; (swapped)
(a2r_2 a2 a1) r)) (in_2 a1 a0 r))) 
 :named lemmaaa5ad85c 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_2x1. direction: join to in
(forall ((a0 Atom)(a1 Atom)(r Rel2)) (=> (in_1 a0 (join_2x1 r (a2r_1 a1))) (in_2 a0 a1 r))) 
 :named lemmaec517cdd 
 ) 
 )
(assert
 (! 
  ; 1. lemma for join_1x2. direction: join to in
(forall ((a1 Atom)(a0 Atom)(r Rel2)) (=> (in_1 a0 (join_1x2 ; (swapped)
(a2r_1 a1) r)) (in_2 a1 a0 r))) 
 :named lemmaf97e883f 
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
