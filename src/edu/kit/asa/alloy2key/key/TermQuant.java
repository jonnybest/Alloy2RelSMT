/**
 * Created on 13.02.2011
 */
package edu.kit.asa.alloy2key.key;

import java.util.List;

import edu.mit.csail.sdg.alloy4.Pair;

/**
 * A quantified formula (existential/universal)
 * 
 * @author Ulrich Geilmann
 *
 */
public class TermQuant extends Term {

	public enum Quant {
		FORALL, EXISTS
	};
	
	private Quant quant;
	
	private Term sub;
	
	private String var;

	private String sort;
	
	/**
	 * construct a quantified formula
	 * @param quantifier
	 * the quantifier
	 * @param sort
	 * the quantification variable's sort
	 * @param variable
	 * the quantification variable
	 * @param sub
	 * the quantification formula
	 */
	public TermQuant (Quant quantifier, String sort, String variable, Term sub) {
		this.quant = quantifier;
		this.sort = sort;
		this.var = variable;
		this.sub = sub;
	}

	@Override
	public String toString() {
		StringBuffer buf = new StringBuffer();
		switch (quant) {
		case FORALL:
			buf.append ("\\forall ");
			break;
		case EXISTS:
			buf.append ("\\exists ");
			break;
		}
		buf.append(sort).append(" ").
			append(var).append("; (").append(sub.toString()).append(")");
		return buf.toString();
	}

	/** {@inheritDoc} */
	@Override
	public String toStringTaclet() {
		StringBuffer buf = new StringBuffer();
		switch (quant) {
		case FORALL:
			buf.append ("\\forall ");
			break;
		case EXISTS:
			buf.append ("\\exists ");
			break;
		}
		buf.append(var).append("; (").append(sub.toStringTaclet()).append(")");
		return buf.toString();
	}

	/** {@inheritDoc} */
	@Override
	public List<Pair<String,String>> getQuantVars() {
		List<Pair<String,String>> decls = sub.getQuantVars();
		decls.add (new Pair<String,String>(sort,var));
		return decls;
	}
	
	/** {@inheritDoc} */
	@Override
	public boolean occurs (String id) {
		if (id.equals(var))
			return true;
		return sub.occurs(id);
	}
	
	/** {@inheritDoc} */
	@Override
	public Term substitute (String a, String b) {
		if (var.equals(a))
			return this;
		return new TermQuant(quant,sort,var,sub.substitute(a,b));
	}
	
	/** {@inheritDoc} */
	@Override
	public Term fill(Term t) {
		return new TermQuant(quant,sort,var,sub.fill(t));
	}

	/** {@inheritDoc} */
	@Override
	public boolean isInt() {
		return false;
	}
	
}
