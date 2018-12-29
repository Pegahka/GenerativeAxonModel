package MachineCallTree;

import java.util.Vector;

import DataStructure.javaDNA.Machine;

public class Node {

	public String name;
	public Machine m;
	public boolean hasparent;
	public Vector<Link> links = new Vector<Link>();
	public boolean hasvited;
	public void print(String s) {
		
		if(hasvited) return;
		hasvited = true;
		s +="  ";
		for(Link l: links)
		{
			System.out.println(s+l.type+": "+l.n.name);
			l.n.print(s);
			
		}
		hasvited = false;
	}
	
}
