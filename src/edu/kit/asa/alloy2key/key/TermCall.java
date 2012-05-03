/**
 * Created on 13.02.2011
 */
package edu.kit.asa.alloy2key.key;

import java.util.LinkedList;
import java.util.List;

import edu.kit.asa.alloy2key.util.Util;
import edu.mit.csail.sdg.alloy4.Pair;

/**
 * Term constructed from a function/predicate call
 * 
 * @author Ulrich Geilmann
 *
 */
public class TermCall extends Term {

	// the function/predicate called
	private String name;
	
	public String name() {
		return name;
	}
	
	// the parameters of the function/predicate call,
	// might be empty but not null
	private Term[] params;
	
	public Term[] params() {
		return params;
	}
	
	/**
	 * construct a function/predicate call
	 * @param name
	 * name of the function or predicate called
	 * @param params
	 * list of the parameter expressions.
	 * might be <code>null</code> if no parameters
	 */
	public TermCall (String name, Term... params) {
		// set name
		this.name = name;
		
		// set parameters if any
		if (params != null)
			this.params = params;
		else
			// params need not be null!
			this.params = new Term[0];
	}
	
	/** {@inheritDoc} */
	@Override
	public List<Pair<String,String>> getQuantVars() {
		List<Pair<String,String>> decls = new LinkedList<Pair<String,String>>();
		// since we are a function and don't have any quantifiers,
		// our quantifiers are those of our parameters
		for (Term t : params) {
			decls.addAll(t.getQuantVars());
		}
		return decls;
	}

	/** {@inheritDoc} */
	@Override
	public String toString() {
		// if this was an actual function call, make it look like a function
		if (params.length > 0)
			// put brackets around and set params
			return String.format("(%s %s)", name, Util.join(params, " "));
		// calls with no parameters cannot have brackets around them!
		return name;
	}

	/** {@inheritDoc} */
	@Override
	public String toStringTaclet() {
		if (params.length > 0) {
			StringBuffer buf = new StringBuffer();
			for (Term t : params) {
				if (buf.length() > 0)
					buf.append(",");
				buf.append(t.toStringTaclet());
			}
			return name + "(" + buf + ")";
		} else
			return name;
	}
	
	/** {@inheritDoc} */
	@Override
	public boolean occurs (String id) {
		// some id occurs iff it occurs inside our parameters
		for (Term t : params)
			if (t.occurs(id))
				return true;
		return false;
	}
	
	/** {@inheritDoc} */
	@Override
	public Term substitute (String a, String b) {
		Term[] p = new Term[params.length];
		for (int i = 0; i < params.length; i++) {
			p[i] = params[i].substitute(a,b);
		}
		return new TermCall(name,p);
	}
	
	/** {@inheritDoc} */
	@Override
	public Term fill(Term t) {
		Term[] p = new Term[params.length];
		for (int i = 0; i < params.length; i++) {
			p[i] = params[i].fill(t);
		}
		return new TermCall(name,p);
	}
	
	/** {@inheritDoc} */
	@Override
	public boolean isInt() {
		return name.equals ("sum") || name.equals("card");
	}

}
