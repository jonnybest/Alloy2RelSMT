/**
 * Created on 13.02.2011
 */
package edu.kit.asa.alloy2relsmt.smt;

import java.util.List;

import edu.mit.csail.sdg.alloy4.Pair;

/**
 * A comprehension
 * 
 * @author Ulrich Geilmann
 *
 */
public class TermCompr extends Term {

	private Term sub;
	
	private String[] vars;
	
	public TermCompr (Term sub, String... vars) {
		this.vars = vars;
		this.sub = sub;
	}

	@Override
	public String toString() {
		StringBuffer buf = new StringBuffer();
		buf.append("("+sub.toString()+")");
		for (int i = vars.length-1; i > 0; --i) {
			buf.insert(0,"bind{Atom "+vars[i]+";}(");
			buf.append (")");
		}
		buf.insert(0, "compr"+vars.length+"{Atom "+vars[0]+";}(");
		buf.append (")");
		return buf.toString();
	}

	/** {@inheritDoc} */
	@Override
	public String toStringTaclet() {
		StringBuffer buf = new StringBuffer();
		buf.append("("+sub.toString()+")");
		for (int i = vars.length-1; i > 0; --i) {
			buf.insert(0,"bind{"+vars[i]+";}(");
			buf.append (")");
		}
		buf.insert(0, "compr"+vars.length+"{"+vars[0]+";}(");
		buf.append (")");
		return buf.toString();
	}

	/** {@inheritDoc} */
	@Override
	public List<Pair<String,String>> getQuantVars() {
		List<Pair<String,String>> decls = sub.getQuantVars();
		for (int i = 0; i < vars.length; ++i) {
			decls.add (new Pair<String,String>("Atom",vars[i]));
		}
		return decls;
	}
	
	/** {@inheritDoc} */
	@Override
	public boolean occurs (String id) {
		for (int i = 0; i < vars.length; ++i)
			if (id.equals(vars[i]))
				return true;
		return sub.occurs(id);
	}
	
	/** {@inheritDoc} */
	@Override
	public Term substitute (String a, String b) {
		for (int i = 0; i < vars.length; ++i)
			if (a.equals(vars[i]))
				return this;
		return new TermCompr(sub.substitute(a,b), vars);
	}
	
	/** {@inheritDoc} 
	 * @throws ModelException */
	@Override
	public Term fill(Term t) throws ModelException {
		return new TermCompr(sub.fill(t),vars);
	}
	
	/** {@inheritDoc} */
	@Override
	public boolean isInt() {
		return false;
	}
	
}
