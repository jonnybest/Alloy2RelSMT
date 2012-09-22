/**
 * Created on 13.02.2011
 */
package edu.kit.asa.alloy2key.smt;


/**
 * A Term that is a variable
 * 
 * @author Ulrich Geilmann
 * @author Jonny
 *
 */
public class TermVar extends Term {

	// the name
	private String name;
	
	// the sort
	private String sort = null;
	
	/**
	 * construct a term from a variable name.
	 *  (use the static var method to create a sorted variable)
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

	/** Produces a <sorted_var> expression for use with binding expressions
	 * , e.g. (a1 Atom)
	 * @return
	 * @throws ModelException 
	 */
	public String toSortedString() throws ModelException{
		if(sort == null)
			throw new ModelException("The variable you're trying to print " +
					"does not have a sort associated with it. " +
					"The resulting expression is invalid.");
		else 
			return "(" + name + " " + sort +")";
	}

	/** sets the sort of this variable
	 * 
	 * @param sort the name of the sort (e.g. "Atom")
	 */
	public void setSort(String sort) {
		this.sort = sort;
	}
	
	/** gets the sort of this variable
	 * 
	 */
	public String getSort() {
		return sort;
	}
	
	/** gets the name of this variable (symbol)
	 * 
	 */
	public String getName() {
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

	/** creates a sorted variable
	 * 
	 * @param sort
	 * @param name
	 * @return
	 */
	public static TermVar var(String sort, String name) {
		TermVar result = new TermVar(name);
		result.sort = sort;
		return result;
	}
	
}
