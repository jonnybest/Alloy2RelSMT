/**
 * Created on 13.02.2011
 */
package edu.kit.asa.alloy2key.key;

import java.util.List;

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
	private Op operator;
	
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
	
	private String buildTerm (String l, String r) {
		switch (operator) {
		case IFF:
			return "("+ l + ")<->(" + r + ")";
		case IMPLIES:
			return "("+ l + ")->(" + r + ")";
		case AND:
			return "("+ l + ")&(" + r + ")";			
		case OR:
			return "("+ l + ")|(" + r + ")";
		case EQUALS:
			return "("+ l + ")=(" + r + ")";
		case LT:
			return "("+ l + ")<(" + r + ")";
		case LTE:
			return "("+ l + ")<=(" + r + ")";
		case GT:
			return "("+ l + ")>(" + r + ")";
		case GTE:
			return "("+ l + ")>=(" + r + ")";
		case PLUS:
			return "("+ l + ")+(" + r + ")";
		case MINUS:
			return "("+ l + ")-(" + r + ")";
		case MUL:
			return "mul("+ l+"," + r + ")";
		case DIV:
			return "div("+ l + "," + r + ")";
		case REM:
			return "mod("+ l + "," + r + ")";
		default:
			throw new RuntimeException ("");
		}
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
	
}
