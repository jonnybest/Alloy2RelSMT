/**
 * Created on 07.02.2011
 */
package edu.kit.asa.alloy2key.key;

import java.io.OutputStream;
import java.io.PrintStream;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

import edu.kit.asa.alloy2key.modules.KeYModule;
import edu.kit.asa.alloy2key.util.Util;

/**
 * capturing output to a .key file
 * 
 * @author Ulrich Geilmann
 *
 */
public class KeYFile {

	public KeYFile () {
		includes = new LinkedList<String>();
		funcs  =  new LinkedList<String>();
		preds  = new LinkedList<String>();
		rules  = new LinkedList<Taclet>();
		assump = new LinkedList<Term>();
		concl  = new LinkedList<Term>();
	}
	
	/** referred modules */
	public Queue<KeYModule> modules = KeYModule.NIL;
	
	/**
	 * Add a function declaration (free text)
	 * @param fun
	 * declaration in KeY syntax, e.g. Rel1 f;
	 */
	public void addFunction (String fun) {
		funcs.add(fun);
	}
	
	/**
	 * Add a typed function declaration with parameters
	 * @param Type
	 * @param Name
	 * @param Parameter-String
	 * @throws ModelException 
	 */
	public void addFunction(String type, String name, List<String> params) throws ModelException {
		String checkedParams = params == null ? "" : Util.join(params, " ");
		String fun = String.format("(declare-fun %s (%s) %s)", name, checkedParams, type);
		funcs.add(fun);
	}
	
	/**
	 * Add a predicate declaration
	 * @param pred
	 * declaration in KeY syntax, e.g. p(Rel1);
	 */
	public void addPredicate (String pred) {
		preds.add(pred);
	}
	
	/**
	 * Add a rule definition
	 * @param rule
	 * the taclet object
	 */
	public void addRule (Taclet rule) {
		rules.add(rule);
	}
	
	/**
	 * Add an assumption
	 * @param f
	 * formula in KeY syntax to be added as assumption
	 */
	public void addAssumption (Term f) {
		if (f != Term.TRUE)
			assump.add(f);
	}
	
	/**
	 * Add a conclusion
	 * @param f
	 * formula in KeY syntax to be added as conclusion
	 */
	public void addConclusion (Term f) {
		concl.add(f);
	}
	
	/**
	 * Add an include statement
	 * @param f
	 * the filename to include
	 */
	public void addInclude (String f) {
		includes.add(f);
	}
	
	private Collection<String> includes;
	private Collection<String> funcs;
	private Collection<String> preds;
	private Collection<Taclet> rules;
	private Collection<Term> assump;
	private Collection<Term> concl;
	
	public void output(OutputStream os) {
		PrintStream out = new PrintStream(os);
		out.println ("\\include \"theory/alloyHeader.key\";");
		for (String s : includes)
			out.println ("\\include \""+s+"\";");
		for (KeYModule m: modules) {
			out.println ("\\include \"theory/"+m.filename()+"\";");
		}
		out.println (";;\\functions {");
		out.println (Util.join(funcs, "\n"));
		out.println (";; end functions}\n");
		out.println ("\\predicates {");
		out.println (Util.join(preds, "\n"));
		out.println ("}\n");
		out.println ("\\rules {");
		out.println (Util.join(rules, "\n"));
		out.println ("}\n");
		out.println ("\\problem {(");
		out.println (Util.join(assump, " &\n"));
		out.println (")-> (");
		out.println (Util.join(concl, " &\n"));
		out.println (")}");
		out.close();
	}


}
