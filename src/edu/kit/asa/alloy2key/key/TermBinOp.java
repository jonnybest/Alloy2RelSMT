/**
 * Created on 13.02.2011
 */
package edu.kit.asa.alloy2key.key;

import java.util.List;

import sun.security.util.Debug;

import edu.mit.csail.sdg.alloy4.Pair;

/**
 * A formula constructed from a binary operation
 * 
 * @author Ulrich Geilmann
 *
 */
public class TermBinOp extends Term {
	
	public enum Op {
		IFF, IMPLIES, AND, OR, EQUALS,
		LT, LTE, GT, GTE, PLUS, MINUS, MUL, DIV, REM, SHL, SHR, SHA
	};
	
	// left/right operand
	private Term left, right;
	
	// the operator
	protected Op operator;
	
	public TermBinOp (Term left, Op op, Term right) {
		this.left = left;
		this.operator = op;
		this.right = right;
	}
	
	@Override
	public String toString() {
		return buildTerm (left.toString(), right.toString());
	}

	/** {@inheritDoc} */
	@Override
	public String toStringTaclet() {
		return buildTerm (left.toStringTaclet(), right.toStringTaclet());
	}
	
	/** builds SMT style terms. some expressions may be z3-only 
	 * @param l left hand side
	 * @param r right hand side
	 * @return a string in SMT syntax
	 */
	private String buildTerm (String l, String r) {
		switch (operator) {	
		case IFF:
			Debug.println("Warning", "\"iff\" operator is deprecated. Using \"=\" instead.");
			return "(= "+ l + " " + r + ")";	// there is no more "iff" operator in SMT. replacing with equality
		case IMPLIES:
			return "(=> "+ l + " " + r + ")";	// smt-syntax
		case AND:
			return "(and "+ l + " " + r + ")";	// smt-syntax
		case OR:
			return "(or "+ l + " " + r + ")";	// smt-syntax
		case EQUALS:
			return "(= "+ l + " " + r + ")";	// smt-syntax
		case LT:
			return "(< "+ l + " " + r + ")";	// smt-syntax
		case LTE:
			return "(<= "+ l + " " + r + ")";	// smt-syntax
		case GT:
			return "(> "+ l + " " + r + ")";	// smt-syntax
		case GTE:
			return "(>= "+ l + " " + r + ")";	// smt-syntax
		case PLUS:
			return "(+ "+ l + " " + r + ")";	// smt-syntax
		case MINUS:
			return "(- "+ l + " " + r + ")";	// smt-syntax
		case MUL:
			return "(* "+ l+" " + r + ")";	    // smt-syntax
		case DIV:
			return "(div "+ l + " " + r + ")";	// smt-syntax
		case REM:
			return "(mod "+ l + " " + r + ")";	// smt-syntax
		default:
			throw new RuntimeException(new ModelException("This binary term does not know how to deal with this operator: "+ operator.name()) );
		}
	}
	
	/**
	 * @return
	 * formula representing <code>this & right</code>
	 */
	public Term and (Term right) {
		if (right == TRUE)
			return this;
		if (this.operator == Op.AND) {
			return new TermVarOp(this.operator, this.left, this.right, right);
		}
		return new TermBinOp (this,TermBinOp.Op.AND,right);
	}
	
	/**
	 * @return
	 * formula representing <code>this | right</code>
	 */
	public Term or (Term right) {
		if (right == TRUE)
			return this;
		if (this.operator == Op.OR) {
			return new TermVarOp(this.operator, this.left, this.right, right);
		}
		return new TermBinOp (this,TermBinOp.Op.OR,right);
	}

	/** {@inheritDoc} */
	@Override
	public List<Pair<String,String>> getQuantVars() {
		List<Pair<String,String>> decls = left.getQuantVars();
		decls.addAll(right.getQuantVars());
		return decls;
	}

	/** {@inheritDoc} */
	@Override
	public boolean occurs (String id) {
		return left.occurs(id) || right.occurs(id);
	}

	/** {@inheritDoc} */
	@Override
	public Term substitute (String a, String b) {
		return new TermBinOp(left.substitute(a,b), operator, right.substitute(a,b));
	}
	
	/** {@inheritDoc} */
	@Override
	public Term fill(Term t) {
		return new TermBinOp(left.fill(t), operator, right.fill(t));
	}
	
	/** {@inheritDoc} */
	@Override
	public boolean isInt() {
		switch (operator) {
		case PLUS:
		case MINUS:
		case MUL:
		case DIV:
		case REM:
		case SHL:
		case SHR:
		case SHA:
			return true;
		default:
			return false;
		}
	}
	
	public static Term equals(TermVar[] leftTuple, TermVar[] rightTuple) {
		if (leftTuple == null || rightTuple == null)
			return TRUE;
		Term aEqualsBTerm = Term.TRUE;
		for(int i = 0; i < leftTuple.length; i++)
		{
			aEqualsBTerm = aEqualsBTerm.and(leftTuple[i].equal(rightTuple[i]));
		}
		return aEqualsBTerm;
	}
}
