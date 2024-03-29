/**
 * Created on 07.02.2011
 */
package edu.kit.asa.alloy2relsmt.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.JarURLConnection;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLConnection;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.LinkedList;
import java.util.List;
import java.util.jar.JarEntry;

import edu.kit.asa.alloy2relsmt.smt.TermVar;

/**
 * @author Ulrich Geilmann
 */
public class Util {
	
	/**
	 * join elements of a collection into a String
	 * @param list
	 * elements are transformed to Strings using the {@link Object#toString() toString()} method
	 * @param sep
	 * separation String
	 * @return
	 * concatenation of all elements in the list,
	 * separated by the separation String
	 */
	public static String join (Iterable<?> list, String sep) {
		StringBuffer buf = new StringBuffer();
		for (Object o : list) {
			if (buf.length() > 0)
				buf.append (sep);
			buf.append (o.toString());			
		}
		return buf.toString();
	}
	
	/**
	 * join elements of an Array into a String
	 * @param list
	 * elements are transformed to Strings using the {@link Object#toString() toString()} method
	 * @param sep
	 * separation String
	 * @return
	 * concatenation of all elements in the list,
	 * separated by the separation String
	 */
	public static String join (Object[] list, String sep) {
		StringBuffer buf = new StringBuffer();
		for (Object o : list) {
			if (buf.length() > 0)
				buf.append (sep);
			buf.append (o.toString());			
		}
		return buf.toString();
	}

	/**
	 * join elements of a collection into a String
	 * @param list
	 * the elements to be joined
	 * @param format
	 * the format to which the elements are applied
	 * before joining into the string
	 * @param sep
	 * separation String
	 * @return
	 * concatenation of all elements in the list,
	 * applied to the format String, and separated
	 * by the separation String
	 */
	public static String joinWithFormat (Iterable<?> list, String format, String sep) {
		StringBuffer buf = new StringBuffer();
		for (Object o : list) {
			if (buf.length() > 0)
				buf.append (sep);
			buf.append (String.format(format,o));			
		}
		return buf.toString();
	}
	
	/**
	 * remove the prefix (e.g. {@literal "this/"}) from <code>s</code>, if present
	 */
	public static String removePrefix (String s) {
		int i = s.indexOf('/');
		if (i != -1)
			return removePrefix(s.substring(i+1));
		return s;
	}
	
	/**
	 * @return a list with all entries of a directory, specified by
	 * <code>url</code>. Might be a directory in a jar archive!
	 */
	public static List<String> listEntries (URL url) {
		LinkedList<String> list = new LinkedList<String>();
		try {
			URLConnection conn = url.openConnection();
			if (conn instanceof JarURLConnection) {
				String prefix = ((JarURLConnection) conn).getEntryName();
				for (Enumeration<JarEntry> entries = ((JarURLConnection) conn).getJarFile().entries();
					entries.hasMoreElements();) {
					final JarEntry e = entries.nextElement();
					if (e.getName().startsWith(prefix) && !e.isDirectory())
						list.add (e.getName());
				}
				return list;
			}
		} catch (IOException e) {
			System.err.println (e);
		}
		
		try {
			File f = new File (url.toURI());
			String[] files = f.list();
			for (int i = 0; i < files.length; i++) {
				list.add(files[i]);
			}
			return list;
		} catch (URISyntaxException e) {
			System.err.println (e);
		}
		
		return null;
		
	}
	
	public static void copyStream (InputStream in, OutputStream out) throws IOException {
		byte[] buf = new byte[1024];
		int len;
		while ((len = in.read(buf)) > 0)
			out.write(buf, 0, len);
		in.close();
		out.close();
	}
	
	/** creates the concatenation of two arrays
	 * 
	 * @param first array containing the first few elements
	 * @param second array containing the last few elements
	 * @return the concatenation of the two input arrays
	 * @see http://stackoverflow.com/posts/784842/revisions
	 */
	public static <T> T[] concat(T[] first, T[] second) {
		T[] result = Arrays.copyOf(first, first.length + second.length);
		System.arraycopy(second, 0, result, first.length, second.length);
		return result;
	}
	
	/** creates the concatenation of two arrays
	 * 
	 * @param first array containing the first few elements
	 * @param second array containing the last few elements
	 * @return the concatenation of the two input arrays
	 * @see http://stackoverflow.com/posts/784842/revisions
	 */
	public static <T> T[] concat(T[] first, T second) {
		T[] result = Arrays.copyOf(first, first.length + 1);
		result[first.length] = second;
		return result;
	}

	public static TermVar[] reverse(TermVar[] reverseme) {
		TermVar[] result = new TermVar[reverseme.length];
		for(int i = 0; i < reverseme.length; i++) {
		    result[i] = reverseme[reverseme.length - 1 - i];
		}
		return result;
	}

	public static String tryHashFile(String sourcefilename) {
		StringBuilder hash = new StringBuilder();
		File sourcefile = new File(sourcefilename);
		if(sourcefile.exists()){
			try {
			InputStream fis =  new FileInputStream(sourcefilename);
	        try
	        {
	             byte[] buffer = new byte[1024];
	             MessageDigest complete = MessageDigest.getInstance("MD5"); 
	             int numRead;
	             do 
	             {
	                 numRead = fis.read(buffer);
	                 if (numRead > 0) 
	                 {
	                     complete.update(buffer, 0, numRead);
	                 }
	             } while (numRead != -1);
	             byte[] byteresult = complete.digest();
	             
	             for(byte b : byteresult){
	            	 hash.append(String.format("%2X", b));
	             }	             
	         } catch (NoSuchAlgorithmException e) {
				System.err.println("MD5 is not available on this system. Some checksums may be missing from output file.");
			}
	         finally
	         {
	             fis.close();
	         }
			}
			catch(IOException e){
				System.err.println("Could not open file " + sourcefilename + " for checksum generation. Some checksums may be missing from output file.");
			}
		}
		return hash.toString();
	}
}
