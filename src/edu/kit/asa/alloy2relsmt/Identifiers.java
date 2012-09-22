/**
 * Created on 07.04.2011
 */
package edu.kit.asa.alloy2relsmt;


/**
 * mapping Alloy entities to KeY identifiers
 * 
 * @author Ulrich Geilmann
 *
 */
public interface Identifiers {
	
	/**
	 * @return
	 * the KeY identifier associated with a given
	 * Alloy entity
	 */
	public abstract String id(Object o);
	
	/**
	 * set the identifier for <code>o</code> to <code>id</code>
	 * @return
	 * true on success, false otherwise
	 */
	public boolean setId(Object o, String id);
	
	/**
	 * @return
	 * a new (unused) identifier, being similar to <code>base</code>
	 */
	public String newId(String base);
	
}
