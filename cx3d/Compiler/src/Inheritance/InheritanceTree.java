package Inheritance;

import java.util.HashMap;
import java.util.Vector;

import Compiler.AbstractVisiter;
import DataStructure.javaDNA.DNA;
import DataStructure.javaDNA.Machine;

public class InheritanceTree extends AbstractVisiter {
	public  HashMap<String,InheritanceNode> nodes = new HashMap<String,InheritanceNode>();
	public DNA dna;
	
	public InheritanceTree()
	{
		
	}
	
	public void visit(DNA dna)
	{
		this.dna = dna;
		addMachine("SomaMachine");
		addMachine("NeuriteMachine");
	}
	
	private void addMachine(String bm)
	{
		InheritanceNode hn = new InheritanceNode(); 
		hn.m  = null;
		hn.name = bm;
		nodes.put(bm, hn);
		findallfollowUP(bm,hn.nodes);
	}
	
	private void findallfollowUP(String basemachine, HashMap<String,InheritanceNode> nodes) {
		for(Machine m:dna.machines)
		{
			if(m.basemachine.equals(basemachine))
			{
				InheritanceNode hn = new InheritanceNode(); 
				hn.m  = m;
				hn.name = m.name;
				nodes.put(m.name, hn);
				findallfollowUP(m.name,hn.nodes);
			}
		}
	}

	
}


class InheritanceNode
{
	public String name;
	public Machine m;
	public HashMap<String,InheritanceNode> nodes = new HashMap<String,InheritanceNode>();
}