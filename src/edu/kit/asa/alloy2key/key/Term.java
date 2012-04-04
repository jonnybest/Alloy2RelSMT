package edu.kit.asa.alloy2key.key;

import java.util.LinkedList;
import java.util.List;

import edu.kit.asa.alloy2key.key.TermQuant.Quant;
import edu.mit.csail.sdg.alloy4.Pair;

public abstract class Term {
	
	/**
	 * check whether a variable occurs in this term
	 * @param id
	 * the identifier to search for
	 * @return
	 * true iff a variable of name <code>id</code> occurs
	 * in the term.
	 */
	public abstract boolean occurs (String id);
	
	/**
	 * perform substitution
	 * @param a
	 * the variable to be replaced
	 * @param b
	 * substitute a with b
	 * @return
	 * the term with a replaced with b
	 */
	public abstract Term substitute (String a, String b);
	
	/**
	 * get all quantification variables used in this term.
	 * @return
	 * a list of pairs of sort and name of the quantification variables.
	 */
	public List<Pair<String,String>> getQuantVars() {
		return new LinkedList<Pair<String,String>>();
	}
	
	/**
	 * @return
	 * String representation of the term
	 */
	@Override
	public String toString() {
		return super.toString();
	}

	/**
	 * @return
	 * String representation of the term, for use
	 * within a taclet. i.e. quantification variables
	 * have to be declared as schema variables
	 */
	public abstract String toStringTaclet();
	
	/*
	 * Convenience methods for building complex terms
	 * ----------------------------------------------
	 */
	
	/**
	 * @return
	 * formula representing <code>this | right</code>
	 */
	public Term or (Term right) {
		if (right == FALSE)
			return this;
		return new TermBinOp (this,TermBinOp.Op.OR,right);
	}

	/**
	 * @return
	 * formula representing <code>this & right</code>
	 */
	public Term and (Term right) {
		if (right == TRUE)
			return this;
		return new TermBinOp (this,TermBinOp.Op.AND,right);
	}

	/**
	 * @return
	 * formula representing <code>this -> right</code>
	 */
	public Term implies (Term right) {
		if (right == TRUE)
			return TRUE;
		return new TermBinOp (this,TermBinOp.Op.IMPLIES,right);
	}

	/**
	 * @return
	 * formula representing <code>this <-> right</code>
	 */
	public Term iff (Term right) {
		return new TermBinOp (this,TermBinOp.Op.IFF,right);
	}
	
	/**
	 * @return
	 * formula representing <code>this = right</code>
	 */
	public Term equal (Term right) {
		return new TermBinOp (this,TermBinOp.Op.EQUALS,right);
	}

	/**
	 * @return formula representing <code>this < right</code>
	 */
	public Term lt (Term right) {
		return new TermBinOp (this,TermBinOp.Op.LT,right);
	}
	
	/**
	 * @return formula representing <code>this > right</code>
	 */
	public Term gt (Term right) {
		return new TermBinOp (this,TermBinOp.Op.GT,right);
	}

	/**
	 * @return formula representing <code>this <= right</code>
	 */
	public Term lte (Term right) {
		return new TermBinOp (this,TermBinOp.Op.LTE,right);
	}

	/**
	 * @return formula representing <code>this >= right</code>
	 */
	public Term gte (Term right) {
		return new TermBinOp (this,TermBinOp.Op.GTE,right);
	}

	/**
	 * @return formula representing <code>this - right</code>
	 */
	public Term minus (Term right) {
		return new TermBinOp (this,TermBinOp.Op.MINUS,right);
	}
	
	/**
	 * @return formula representing <code>this + right</code>
	 */
	public Term plus (Term right) {
		return new TermBinOp (this,TermBinOp.Op.PLUS,right);
	}
	
	/**
	 * @return formula representing <code>this * right</code>
	 */
	public Term mul (Term right) {
		return new TermBinOp (this,TermBinOp.Op.MUL,right);
	}
	
	/**
	 * @return formula representing <code>this / right</code>
	 */
	public Term div (Term right) {
		return new TermBinOp (this,TermBinOp.Op.DIV,right);
	}
	
	/**
	 * @return formula representing <code>this % right</code>
	 */
	public Term rem (Term right) {
		return new TermBinOp (this,TermBinOp.Op.REM,right);
	}

	//TODO missing binops
	
	/**
	 * @return
	 * formula representing <code>\forall sort var; this</code>
	 */
	public Term forall (String sort, String var) {
		return forall(sort, var, this);
	}
	
	/**
	 * @return
	 * formula representing <code>\exists sort var; this</code>
	 */
	public Term exists (String sort, String var) {
		return exists(sort, var, this);
	}

	/**
	 * @return
	 * formula representing <code>!this</code>
	 */
	public Term not() {
		return new TermUnary(TermUnary.Op.NOT,this);
	}
	
	/**
	 * @return
	 * term representing <code>\if (this) \then sub1 \else sub2
	 */
	public Term ite(Term sub1, Term sub2) {
		return new TermITE(this,sub1,sub2);
	}
	
	/**
	 * @return
	 * formula representing <code>compr{vars[0];}(bind{vars[1];}...(this))</code>
	 */
	public Term compr(String... vars) {
		return new TermCompr(this,vars);
	}
	
	/*
	 * Convenience methods for initial creation of terms
	 */
	public static final Term FALSE = new Term.False();
	public static final Term TRUE = new Term.True();
	public static final Term HOLE = new Hole();
	
	public static Term call(String name, Term... params) {
		return new TermCall (name, params);
	}
	
	public static Term var(String name) {
		return new TermVar (name);
	}
	
	public static Term forall(String sort, String var, Term sub) {
		return new TermQuant(Quant.FORALL, sort, var, sub);
	}
	
	public static Term exists(String sort, String var, Term sub) {
		return new TermQuant(Quant.EXISTS, sort, var, sub);
	}
	
	public static Term number(int n) {
		return new TermNumber(n);
	}
	
	/**
	 * @return <code>true</code> iff this term is of type int
	 */
	public abstract boolean isInt();
	
	/**
	 * fill all occurrences of <code>HOLE</code> with <code>t</code>
	 */
	public abstract Term fill(Term t);
	
	/**
	 * Placeholder in a Term. Can later be replaced with
	 * any term using <code>fill</code>
	 */
	public static final class Hole extends Term {

		/** {@inheritDoc} */
		@Override
		public boolean occurs(String id) {
			return false;
		}

		/** {@inheritDoc} */
		@Override
		public Term substitute(String a, String b) {
			return this;
		}

		/** {@inheritDoc} */
		@Override
		public String toStringTaclet() {
			throw new RuntimeException ("Unexpected!");
		}

		/** {@inheritDoc} */
		@Override
		public Term fill(Term t) {
			return t;
		}
		
		/** {@inheritDoc} */
		@Override
		public boolean isInt() {
			return false;
		}

	}
	
	public static final class True extends Term {

		/** {@inheritDoc} */
		@Override
		public String toStringTaclet() {
			return "true";
		}

		/** {@inheritDoc} */
		@Override
		public String toString() {
			return "true";
		}

		/** {@inheritDoc} */
		@Override
		public Term or(Term right) {
			return this;
		}
		
		/** {@inheritDoc} */
		@Override
		public Term implies(Term right) {
			return right;
		}

		/** {@inheritDoc} */
		@Override
		public Term and(Term right) {
			return right;
		}
		
		/** {@inheritDoc} */
		@Override
		public boolean occurs (String id) {
			return false;
		}

		/** {@inheritDoc} */
		@Override
		public Term substitute (String a, String b) {
			return this;
		}
		
		/** {@inheritDoc} */
		@Override
		public Term fill(Term t) {
			return this;
		}
		
		/** {@inheritDoc} */
		@Override
		public Term forall (String sort, String var) {
			return this;
		}
	
		/** {@inheritDoc} */
		@Override
		public boolean isInt() {
			return false;
		}
		
	}
	
	public static final class False extends Term {

		/** {@inheritDoc} */
		@Override
		public String toStringTaclet() {
			return "false";
		}

		/** {@inheritDoc} */
		@Override
		public String toString() {
			return "false";
		}

		/** {@inheritDoc} */
		@Override
		public Term or(Term right) {
			return right;
		}

		/** {@inheritDoc} */
		@Override
		public Term and(Term right) {
			return this;
		}

		/** {@inheritDoc} */
		@Override
		public boolean occurs (String id) {
			return false;
		}

		/** {@inheritDoc} */
		@Override
		public Term substitute (String a, String b) {
			return this;
		}
		
		/** {@inheritDoc} */
		@Override
		public Term fill(Term t) {
			return this;
		}
		
		/** {@inheritDoc} */
		@Override
		public boolean isInt() {
			return false;
		}
		
	}


}
