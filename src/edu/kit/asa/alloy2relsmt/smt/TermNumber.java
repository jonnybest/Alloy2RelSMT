/**
 * Created on 28.04.2011
 */
package edu.kit.asa.alloy2relsmt.smt;

/**
 * integer constant
 * 
 * @author Ulrich Geilmann
 *
 */
public class TermNumber extends Term {
	
	private int n;
	
	/** integer constant **/
	public TermNumber (int n) {
		this.n = n;
	}

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
		return ""+n;
	}

	/** {@inheritDoc} */
	@Override
	public String toString() {
		return ""+n;
	}

	/** {@inheritDoc} */
	@Override
	public Term fill(Term t) {
		return this;
	}
	
	/** {@inheritDoc} */
	@Override
	public boolean isInt() {
		return true;
	}

}
