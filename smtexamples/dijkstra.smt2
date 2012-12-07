; file: D:\Entwicklung\workspace\alloy2relsmt\smtexamples\dijkstra.als 
; hash: 5535188F55AFACF288 830D14C B1042
(set-logic AUFLIA)
(set-option :macro-finder true)
;; sorts
(declare-sort Atom)
(declare-sort Rel1)
(declare-sort Rel2)
(declare-sort Rel3)
;; --end sorts

;; functions
(declare-fun Deadlock () Bool)
(declare-fun GrabMutex (Rel1 Rel1 Rel1 Rel1) Bool)
(declare-fun GrabOrRelease () Bool)
(declare-fun GrabbedInOrder () Bool)
(declare-fun Initial (Rel1) Bool)
(declare-fun IsFree (Rel1 Rel1) Bool)
(declare-fun IsStalled (Rel1 Rel1) Bool)
(declare-fun Mutex () Rel1)
(declare-fun Process () Rel1)
(declare-fun ReleaseMutex (Rel1 Rel1 Rel1 Rel1) Bool)
(declare-fun ShowDijkstra () Bool)
(declare-fun State () Rel1)
(declare-fun a2r_1 (Atom) Rel1)
(declare-fun at (Rel1 Int) Atom)
(declare-fun diff_1 (Rel1 Rel1) Rel1)
(declare-fun disjoint_1 (Rel1 Rel1) Bool)
(declare-fun domRestr_2 (Rel1 Rel2) Rel2)
(declare-fun finite (Rel1) Bool)
(declare-fun firstMutex () Rel1)
(declare-fun firstState () Rel1)
(declare-fun holds () Rel3)
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
(declare-fun in_3 (Atom Atom Atom Rel3) Bool)
(declare-fun join_1x2 (Rel1 Rel2) Rel1)
(declare-fun join_1x3 (Rel1 Rel3) Rel2)
(declare-fun lastMutex () Rel1)
(declare-fun lastState () Rel1)
(declare-fun nextMutex () Rel2)
(declare-fun nextState () Rel2)
(declare-fun nextsMutex (Rel1) Rel1)
(declare-fun nextsState (Rel1) Rel1)
(declare-fun no_1 (Rel1) Bool)
(declare-fun no_2 (Rel2) Bool)
(declare-fun none () Rel1)
(declare-fun one_1 (Rel1) Bool)
(declare-fun ord (Rel1 Atom) Int)
(declare-fun prod_1x1 (Rel1 Rel1) Rel2)
(declare-fun prod_2x1 (Rel2 Rel1) Rel3)
(declare-fun some_1 (Rel1) Bool)
(declare-fun some_3 (Rel3) Bool)
(declare-fun subset_1 (Rel1 Rel1) Bool)
(declare-fun subset_2 (Rel2 Rel2) Bool)
(declare-fun subset_3 (Rel3 Rel3) Bool)
(declare-fun trans (Rel2) Bool)
(declare-fun transClos (Rel2) Rel2)
(declare-fun transp (Rel2) Rel2)
(declare-fun union_1 (Rel1 Rel1) Rel1)
(declare-fun union_2 (Rel2 Rel2) Rel2)
(declare-fun waits () Rel3)
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
  ; 'there is no empty ordered relation' axiom for nextState
(not (= none State)) 
 :named axiom25bd53d4 
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
  ; Axiom for domain restriction of arity 2
(forall ((a0 Atom)(a1 Atom)(R Rel2)(S Rel1)(b Atom)) (=> (and 
    (in_2 a0 a1 R)
    (in_1 b S)
    (in_2 a0 a1 (domRestr_2 S R))
  ) (= a0 b))) 
 :named axiom395d812a 
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
  ; axiom for firstState
(= firstState (a2r_1 (at State 1))) 
 :named axiom69fd33f0 
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
  ; axiom for nextMutex
(forall ((a Atom)(b Atom)) (=> (and (in_1 a Mutex) (in_1 b Mutex)) (= (in_2 a b nextMutex) (= (ord Mutex b) (+ (ord Mutex a) 1))))) 
 :named axiom6ff6aaf8 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel3)) (= (some_3 A) (exists ((a0 Atom)(a1 Atom)(a2 Atom)) (in_3 a0 a1 a2 A)))) 
 :named axiom7510ecaf 
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
  ; axiom for ord
(forall ((R Rel1)(a Atom)(b Atom)) (=> (and 
    (in_1 a R)
    (in_1 b R)
    (= (ord R a) (ord R b))
  ) (= a b))) 
 :named axiom850049b2 
 ) 
 )
(assert 
 (! 
  ; axiom for at (the reverse of ord)
(forall ((R Rel1)(a Atom)) (=> (in_1 a R) (= (at R (ord R a)) a))) 
 :named axiom9d8f87d2 
 ) 
 )
(assert 
 (! 
  ; axiom for nextState
(forall ((a Atom)(b Atom)) (=> (and (in_1 a State) (in_1 b State)) (= (in_2 a b nextState) (= (ord State b) (+ (ord State a) 1))))) 
 :named axioma246461c 
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
  ; axiom for 'the expression is empty'
(forall ((a0 Atom)(a1 Atom)(R Rel2)) (=> (no_2 R) (not (in_2 a0 a1 R)))) 
 :named axioma8f63eaa 
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
  ; infinite axiom for lastState
(=> (not (finite State)) (= lastState none)) 
 :named axiomb42e46af 
 ) 
 )
(assert 
 (! 
  ; 'there is no empty ordered relation' axiom for nextMutex
(not (= none Mutex)) 
 :named axiombb4cd114 
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
  ; axiom for the function 'nexts' of Mutex
(forall ((e Rel1)) (=> (subset_1 e Mutex) (= (nextsMutex e) (join_1x2 e (transClos nextMutex))))) 
 :named axiomda2a3773 
 ) 
 )
(assert 
 (! 
  (forall ((A Rel1)) (= (some_1 A) (exists ((a0 Atom)) (in_1 a0 A)))) 
 :named axiomdf19d42f 
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
(assert 
 (! 
  ; axiom for firstMutex
(= firstMutex (a2r_1 (at Mutex 1))) 
 :named axiomf05a601e 
 ) 
 )
(assert 
 (! 
  ; axiom for the function 'nexts' of State
(forall ((e Rel1)) (=> (subset_1 e State) (= (nextsState e) (join_1x2 e (transClos nextState))))) 
 :named axiomf652f48f 
 ) 
 )
(assert 
 (! 
  ; infinite axiom for lastMutex
(=> (not (finite Mutex)) (= lastMutex none)) 
 :named axiomfa80f641 
 ) 
 )
;; --end axioms

;; assertions
(assert 
 (! 
  (disjoint_1 State Mutex) 
 :named assert1f7b983 
 ) 
 )
(assert 
 (! 
  (subset_3 waits (prod_2x1 (prod_1x1 State Process) Mutex)) 
 :named assert2bbe2d17 
 ) 
 )
(assert 
 (! 
  (forall ((s Rel1)) (= (Initial s) (no_2 (union_2 (join_1x3 s holds) (join_1x3 s waits))))) 
 :named assert836972aa 
 ) 
 )
(assert 
 (! 
  (= GrabbedInOrder (forall ((pre Atom)) (=> (and (in_1 pre State) (in_1 pre (diff_1 State lastState))) (=> (some_1 (diff_1 (join_1x2 Process (join_1x3 (join_1x2 (a2r_1 pre) nextState) holds)) (join_1x2 Process (join_1x3 (a2r_1 pre) holds)))) (subset_1 (diff_1 (join_1x2 Process (join_1x3 (join_1x2 (a2r_1 pre) nextState) holds)) (join_1x2 Process (join_1x3 (a2r_1 pre) holds))) (nextsMutex (join_1x2 Process (join_1x3 (a2r_1 pre) holds)))))))) 
 :named assert8c542573 
 ) 
 )
(assert 
 (! 
  (= ShowDijkstra (and 
    GrabOrRelease
    Deadlock
    (some_3 waits)
  )) 
 :named assert8f59b801 
 ) 
 )
(assert 
 (! 
  (disjoint_1 Mutex Process) 
 :named assert90c0cf25 
 ) 
 )
(assert 
 (! 
  (forall ((s Rel1)(p Rel1)) (= (IsStalled s p) (some_1 (join_1x2 p (join_1x3 s waits))))) 
 :named asserta4155d9b 
 ) 
 )
(assert 
 (! 
  (subset_3 holds (prod_2x1 (prod_1x1 State Process) Mutex)) 
 :named assertb7e74961 
 ) 
 )
(assert 
 (! 
  (forall ((s Rel1)(m Rel1)) (= (IsFree s m) (no_1 (join_1x2 m (transp (join_1x3 s holds)))))) 
 :named assertbfeb9be1 
 ) 
 )
(assert 
 (! 
  (forall ((s Rel1)(p Rel1)(m Rel1)(s_ Rel1)) (= (ReleaseMutex s p m s_) (and 
    (not (IsStalled s p))
    (subset_1 m (join_1x2 p (join_1x3 s holds)))
    (= (join_1x2 p (join_1x3 s_ holds)) (diff_1 (join_1x2 p (join_1x3 s holds)) m))
    (no_1 (join_1x2 p (join_1x3 s_ waits)))
    (ite (no_1 (join_1x2 m (transp (join_1x3 s waits)))) (and (no_1 (join_1x2 m (transp (join_1x3 s_ holds)))) (no_1 (join_1x2 m (transp (join_1x3 s_ waits))))) (exists ((lucky Atom)) (and 
    (in_1 lucky Process)
    (in_1 lucky (join_1x2 m (transp (join_1x3 s waits))))
    (and (= (join_1x2 m (transp (join_1x3 s_ waits))) (diff_1 (join_1x2 m (transp (join_1x3 s waits))) (a2r_1 lucky))) (= (join_1x2 m (transp (join_1x3 s_ holds))) (a2r_1 lucky)))
  )))
    (forall ((mu Atom)) (=> (and (in_1 mu Mutex) (in_1 mu (diff_1 Mutex m))) (and (= (join_1x2 (a2r_1 mu) (transp (join_1x3 s_ waits))) (join_1x2 (a2r_1 mu) (transp (join_1x3 s waits)))) (= (join_1x2 (a2r_1 mu) (transp (join_1x3 s_ holds))) (join_1x2 (a2r_1 mu) (transp (join_1x3 s holds)))))))
  ))) 
 :named assertc7eef4ac 
 ) 
 )
(assert 
 (! 
  (= GrabOrRelease (and (Initial firstState) (forall ((pre Atom)) (=> (and (in_1 pre State) (in_1 pre (diff_1 State lastState))) (or 
    (and (= (join_1x3 (join_1x2 (a2r_1 pre) nextState) holds) (join_1x3 (a2r_1 pre) holds)) (= (join_1x3 (join_1x2 (a2r_1 pre) nextState) waits) (join_1x3 (a2r_1 pre) waits)))
    (exists ((p Atom)(m Atom)) (and 
    (in_1 p Process)
    (in_1 m Mutex)
    (GrabMutex (a2r_1 pre) (a2r_1 p) (a2r_1 m) (join_1x2 (a2r_1 pre) nextState))
  ))
    (exists ((p Atom)(m Atom)) (and 
    (in_1 p Process)
    (in_1 m Mutex)
    (ReleaseMutex (a2r_1 pre) (a2r_1 p) (a2r_1 m) (join_1x2 (a2r_1 pre) nextState))
  ))
   ))))) 
 :named asserte6ef11f1 
 ) 
 )
(assert 
 (! 
  (= Deadlock (and (some_1 Process) (exists ((s Atom)) (and (in_1 s State) (forall ((p Atom)) (=> (in_1 p Process) (some_1 (join_1x2 (a2r_1 p) (join_1x3 (a2r_1 s) waits))))))))) 
 :named asserte800516c 
 ) 
 )
(assert 
 (! 
  (disjoint_1 State Process) 
 :named assertf3345053 
 ) 
 )
(assert 
 (! 
  (forall ((s Rel1)(p Rel1)(m Rel1)(s_ Rel1)) (= (GrabMutex s p m s_) (and 
    (not (IsStalled s p))
    (not (subset_1 m (join_1x2 p (join_1x3 s holds))))
    (ite (IsFree s m) (and (= (join_1x2 p (join_1x3 s_ holds)) (union_1 (join_1x2 p (join_1x3 s holds)) m)) (no_1 (join_1x2 p (join_1x3 s_ waits)))) (and (= (join_1x2 p (join_1x3 s_ holds)) (join_1x2 p (join_1x3 s holds))) (= (join_1x2 p (join_1x3 s_ waits)) m)))
    (forall ((otherProc Atom)) (=> (and (in_1 otherProc Process) (in_1 otherProc (diff_1 Process p))) (and (= (join_1x2 (a2r_1 otherProc) (join_1x3 s_ holds)) (join_1x2 (a2r_1 otherProc) (join_1x3 s holds))) (= (join_1x2 (a2r_1 otherProc) (join_1x3 s_ waits)) (join_1x2 (a2r_1 otherProc) (join_1x3 s waits))))))
  ))) 
 :named assertf88c6de1 
 ) 
 )
;; --end assertions

;; command
(assert 
 (! 
  (not (=> (and 
    (some_1 Process)
    GrabOrRelease
    GrabbedInOrder
  ) (not Deadlock))) 
 :named command7b5f1e07 
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
