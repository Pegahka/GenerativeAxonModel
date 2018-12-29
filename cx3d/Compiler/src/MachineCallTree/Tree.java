package MachineCallTree;

import java.util.HashMap;
import java.util.Vector;

import Compiler.AbstractVisiter;
import DataStructure.javaDNA.DNA;
import DataStructure.javaDNA.FunctionCall;
import DataStructure.javaDNA.Machine;
import DataStructure.javaDNA.NewOperator;
import DataStructure.javaDNA.Value;

public class Tree extends AbstractVisiter{
	
	public Node n= new Node();
	public HashMap<String,Machine> machines = new HashMap<String,Machine>();
	public HashMap<String, Node> nodes = new HashMap<String, Node>();
	public Node currentNode;
	
	public Tree()
	{
		
	}
	
	
	
	
	
	@Override
	public void visit(DNA s) {
		for (Machine m : s.machines) {
			machines.put(m.name, m);
		}
		for (Machine m : s.machines) {
			visit(m);
		}
		this.n.name = "start";
		for(Node o :nodes.values())
		{
			if(o.m.isabstract) continue;
			if(!o.hasparent)
			{
				n.links.add(new Link(o, "Start"));
			}
		}
		
	}
	
	public void Print()
	{
		n.print("");
	}
	
	
	private  Node getNode(String name)
	{
		if(!nodes.containsKey(name))
		{
			Node n = new Node();
			n.m = machines.get(name);
			n.name = name;
			nodes.put(name, n);
		}
		return nodes.get(name);
	}
	
	
	@Override
	public void visit(Machine s) {
		
		this.currentNode= getNode(s.name);
		super.visit(s);
	}
	
	@Override
	public void visit(FunctionCall s) {
		if(s.name.equals("replicate") || s.name.equals("instantiate")|| s.name.equals("fork") )
		{
			Vector<Machine> news = getMachineFromNew(s.vals); 
			for(Machine m:news)
			{
				Node n = getNode(m.name);
				n.hasparent = true;
				currentNode.links.add(new Link (n,s.name));
			}
		}
		
		super.visit(s);
	}
	
	
	private Vector<Machine> getMachineFromNew(Vector<Value> vals) {
		Vector<Machine> machs = new Vector<Machine>();
		for(Value v:vals)
		{
			if(v instanceof NewOperator)
			{
				
				NewOperator o = (NewOperator) v;
				if(o.val instanceof FunctionCall)
				{
					FunctionCall f = (FunctionCall)o.val;
					if(machines.containsKey(f.name))
					{
						machs.add(machines.get(f.name));
					}
				}
			
			}
			
		}
		return machs;
	}


	
}
