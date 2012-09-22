/**
 * 
 */
package edu.kit.asa.alloy2key.smt;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

import edu.kit.asa.alloy2key.util.Util;

import sun.security.util.Debug;

/**
 * @author Jonny
 *
 */
public class TermVarOp extends TermBinOp {

	List<Term> termList;
	
	/**
	 * @param left
	 * @param op
	 * @param right
	 */
	public TermVarOp(Op op, Term ... terms) {
		super(terms[0], op, terms[1]);
		termList = Arrays.asList(terms);
	}
	
	public Term and(Term right){
		if (operator == Op.AND) {
			safeAdd(right);
			return this;
		} else {
			return new TermBinOp (this,TermBinOp.Op.AND,right);
		}
	}

	private void safeAdd(Term right) {
		try {
			termList.add(right);
		} catch (UnsupportedOperationException e) {
			LinkedList<Term> otherList = new LinkedList<Term>(termList);
			otherList.add(right);
			termList = otherList;
		}
	}
	
	public Term or(Term right){
		if (operator == Op.OR) {
			safeAdd(right);
			return this;
		} else {
			return new TermBinOp (this,TermBinOp.Op.OR,right);
		}
	}
	
	@Override
	public String toString() {
		switch (operator) {	
		case AND:
			return "(and \n    "+ Util.join(termList, "\n    ") + "\n  )";	// smt-syntax
		case OR:
			return "(or \n    "+ Util.join(termList, "\n    ") + "\n   )";	// smt-syntax
		default:
			throw new RuntimeException(new ModelException("This variadic term does not know how to deal with this operator: "+ operator.name()) );
		}
	}
}
