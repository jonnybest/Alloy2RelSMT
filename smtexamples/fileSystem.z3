;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;
;; Tailored Background ...
;;

;; Sorts
(declare-sort Rel1)
(declare-sort Rel2)

(declare-sort Tuple1) ;; Tuple1 = Atom
(declare-sort Tuple2)

;; Constants
(declare-fun emptySet_1 () Rel1)

;; Operations 

(declare-fun in_1 (Tuple1 Rel1) Bool)
(declare-fun in_2 (Tuple2 Rel2) Bool)
;// in_n are uninterpreted predicate

(declare-fun subSet_1 (Rel1 Rel1) Bool)
;// Axiomatization of subSet_1

(declare-fun union_1 (Rel1 Rel1) Rel1)
;// Axiomatization of union_1

(declare-fun inter_1 (Rel1 Rel1) Rel1)
;// Axiomatization of inter_1

(declare-fun diff_1 (Rel1 Rel1) Rel1)
;// Axiomatization of diff_1

(declare-fun join_1x2 (Rel1 Rel2) Rel1)
;// Axiomatization of join_1x2

(declare-fun join_2x1 (Rel2 Rel1) Rel1)
;// Axiomatization of join_2x1


(declare-fun rel_1 (Tuple1) Rel1)
;// Axiomatization of rel_1

(declare-fun lone_1 (Rel1) Bool)
;// Axiomatization of lone_1

(declare-fun some_1 (Rel1) Bool)
;// Axiomatization of some_1

(declare-fun one_1 (Rel1) Bool)
;// Axiomatization of one_1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Actual system specification
;;

;; abstract sig FSO 
(declare-fun FSO () Rel1)

;;sig File extends FSO
(declare-fun File () Rel1)

;; sig Dir extends FSO
(declare-fun Dir () Rel1)

;;sig Root extends Dir 
(declare-fun Root () Rel1)

;;parent: Parent -> lone Dir
(declare-fun parent () Rel2)

;; entries: Dir -> set FSO
(declare-fun entries () Rel2)

;; Additional type constraints
(assert
 (subSet_1 File FSO))

(assert
 (subSet_1 Dir FSO))

(assert
 (= (inter_1 File Dir) emptySet_1))

(assert
 (= (union_1 File Dir) FSO))

(assert
 (subSet_1 Dir FSO))

(assert
 (subSet_1 (join_1x2 FSO parent) Dir))

(assert
 (subSet_1 (join_2x1 parent Dir) FSO))

(assert
 (forall ((t Tuple1))
   (=>
    (in_1 t FSO)
    (lone_1 (join_1x2 (rel_1 t) parent)))))

(assert
 (subSet_1 (join_1x2 Dir entries) FSO))

(assert
 (subSet_1 (join_2x1 entries FSO) Dir))


;; fact: one Root
(assert (one_1 Root))

;; fact: no Root.parent
(assert
 (= (join_1x2 Root parent) emptySet_1)
)

;; fact: all o: FSO, d: Dir | o in d.entries => o.parent = d
(assert
 (forall ((o Tuple1) (d Tuple1))
  (=>
   (and
    (in_1 o FSO)
    (in_1 d Dir)
   )
   (=>
    (in_1 o (join_1x2 (rel_1 d) entries))
    (= (join_1x2 (rel_1 d) entries) (rel_1 d))
   ))))



;;assertion:  
;; oneParent {
;;	all o: FSO-Root | one o.parent}
;
(assert
 (not
  (forall ((o Tuple1))
   (=>
    (in_1 o (diff_1 FSO Root))
    (one_1 (join_1x2 (rel_1 o) parent))
   ))))

(check-sat)


