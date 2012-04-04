/**
 * Created on 13.02.2011
 */
package edu.kit.asa.alloy2key.key;


/**
 * A Term that is a variable
 * 
 * @author Ulrich Geilmann
 *
 */
public class TermVar extends Term {

	// the name
	private String name;
	
	/**
	 * construct a term from a variable name.
	 * @param name
	 * the variable name
	 */
	public TermVar (String name) {
		this.name = name;
	}
	
	/** {@inheritDoc} */
	@Override
	public String toString() {
		return name;
	}

	/** {@inheritDoc} */
	@Override
	public String toStringTaclet() {
		return name;
	}
	
	/** {@inheritDoc} */
	@Override
	public boolean occurs (String id) {
		return id.equals(name);
	}

	/** {@inheritDoc} */
	@Override
	public Term substitute (String a, String b) {
		if (name.equals(a))
			return new TermVar(b);
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
