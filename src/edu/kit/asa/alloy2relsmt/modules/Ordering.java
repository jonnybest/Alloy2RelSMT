/**
 * Created on 26.03.2011
 */
package edu.kit.asa.alloy2relsmt.modules;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.util.HashSet;
import java.util.Set;

import edu.kit.asa.alloy2relsmt.Identifiers;
import edu.kit.asa.alloy2relsmt.util.Util;
import edu.mit.csail.sdg.alloy4.ast.Func;
import edu.mit.csail.sdg.alloy4.ast.Module;
import edu.mit.csail.sdg.alloy4.ast.Sig;

/**
 * Organize the translation of the ordering module
 * 
 * @author Ulrich Geilmann
 *
 */
public class Ordering extends KeYModule {

	private Sig inst;
	private Module mod;
	private Identifiers ids;
	
	/** Gets the identifier for this ordering module
	 * 
	 * @return
	 */
	public String getId(){
		return ids.id(inst);
	}
	
	/**
	 * Gets the alias expression of the ordering instance
	 * @return
	 */
	public String getPath(){
		return mod.path();
	}
	
	public Ordering(Module m, Sig inst, Identifiers ids) {
		this.order = 2;
		this.inst = inst;
		this.mod = m;
		this.ids = ids;
		String id = ids.newId(Util.removePrefix(inst.toString()));
		if (!ids.setId(inst, id))
			throw new RuntimeException ("Unexpected!");
		for (Func f : m.getAllFunc()) {
			if (!ids.setId(f, Util.removePrefix(f.label)+id))
				throw new RuntimeException ("Unexpected!");
		}
	}
	
	/** {@inheritDoc} */
	public String filename() {
		return "ordering"+ids.id(inst)+".key";
	}

	/** {@inheritDoc} */
	public void buildModule (File dir) throws IOException {
		replaceAndWrite("/res/modules/ordering.key", new File(dir,filename()));
	}
	
	/** {@inheritDoc} */
	@Override
	public Set<Object> defined() {
		HashSet<Object> ret = new HashSet<Object>();
		ret.add (inst);
		for (Func f : mod.getAllFunc()) {
			ret.add (f);
		}
		return ret;
	}

	
	protected void replaceAndWrite (String res, File f) throws IOException {
		PrintStream out = new PrintStream(new FileOutputStream(f));
		InputStream is = getClass().getResourceAsStream(res);
		if (is == null)
			throw new RuntimeException ("Could not find resource "+res+"!");
		BufferedReader reader = new BufferedReader(new InputStreamReader(is));
		
		String line;
		while ((line = reader.readLine()) != null) {
			out.println(line.replace("<S>", ids.id(inst)));
		}
		reader.close();
		out.close();
	}
	
}
