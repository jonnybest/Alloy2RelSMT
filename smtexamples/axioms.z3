;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;
;; Tailored Background ...
;;
(set-option :produce-models true)
(set-logic UFNIA)


;; Sorts
(declare-sort Rel1 0)
(declare-sort AbstractRel2 2)
(declare-sort AbstractRel3 3)
(define-sort Rel2 () (AbstractRel2 Rel1 Rel1))
(define-sort Rel3 () (AbstractRel3 Rel1 Rel1 Rel1))

(declare-sort Atom 0) ;; Atom = Tuple1

;; Constants
(declare-fun emptyset_1 () Rel1)

;; Operations 
(declare-fun in_1 (Atom Rel1) Bool)
(declare-fun in_2 (Atom Atom Rel2) Bool)
;// in_n are uninterpreted predicate

(declare-fun subset_1 (Rel1 Rel1) Bool)
;// Axiomatization of subSet_1
(assert
 (forall ((t Atom) (r1 Rel1) (r2 Rel1))
   (=
    (subSet_1 r1 r2)
    (=> 
    	(in_1 t r1)
    	(in_1 t r2)))))
;// Axiom to empty set		

(declare-fun union_1 (Rel1 Rel1) Rel1)
;// Axiomatization of union_1
(assert
 (forall ((t Atom) (r1 Rel1) (r2 Rel1))
   (=
     (in_1 t  

(declare-fun inter_1 (Rel1 Rel1) Rel1)
;// Axiomatization of inter_1

(declare-fun diff_1 (Rel1 Rel1) Rel1)
;// Axiomatization of diff_1

(declare-fun join_1x2 (Rel1 Rel2) Rel1)
;// Axiomatization of join_1x2

(declare-fun join_2x1 (Rel2 Rel1) Rel1)
;// Axiomatization of join_2x1


(declare-fun rel_1 (Atom) Rel1)
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



(check-sat)

