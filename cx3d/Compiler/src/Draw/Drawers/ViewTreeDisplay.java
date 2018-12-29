/*
Copyright (C) 2009, 2010 Universität Zürich,
Eidgenossische Technische Hochschule (ETH) Zürich,
Andreas Hauri, Roman Bauer, Toby Weston.

This file is part of CX3D.

CX3D is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

CX3D is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with CX3D.  If not, see <http://www.gnu.org/licenses/>.
*/

	// Do NOT change the following comments, they will be set automatically by SVN.
	// $LastChangedRevision: 2246 $
	// $LastChangedDate: 2010-08-27 17:39:45 +0200 (Fri, 27 Aug 2010) $
	// $LastChangedBy: amw $


package Draw.Drawers;

import Draw.Drawer;
import Draw.*;

import java.awt.Color;
import java.awt.Graphics;

import MachineCallTree.Link;
import MachineCallTree.Node;
import MachineCallTree.Tree;


public class ViewTreeDisplay extends Drawer {
    
	
	public Tree t;
	public ViewTreeDisplay()
	{
		super();
		this.name = "View Trees";
	}

	
	public void draw(Graphics g) {
		if(t ==null) return;
		//drawCyrcle(new Vector2d(0,0), 1);
		double i = t.n.links.size()/20.0*-20;
		int k =0;
		for(Link l:t.n.links)
		{
			if(k%2==0)
				drawTree(g,l.n, new Vector2d(0,i),8,1);
			else
			    drawTree(g,l.n, new Vector2d(0,i),-8,-1);
			k++;
			i+=10;
		}
	}
	
    

    private void drawTree(Graphics g, Node root,Vector2d rootpos,double size,double dir){
    	g.setColor(Color.BLACK);
    	drawCyrcleUnsacaled(rootpos,10);
    	drawString(rootpos, root.m.name +"");
    	
    	
    	if(root.hasvited) return;
    	root.hasvited = true;
    	if(root.links.size()!=0)
    	{
    		
    		double i =size/2;
    		double cur = size/2;
    		if(root.links.size()!=1)
    		{
    			i= 1.0/(root.links.size()-1)*size;
    			cur = 0;
    		}
    		for(Link l:root.links)
    		{
    			Vector2d next = rootpos.plus(new Vector2d(2*dir,cur-size/2));
    			cur+=i;
    			if(l.type.equals("fork"))
    				g.setColor(Color.green);
    			else if(l.type.equals("instantiate"))
    				g.setColor(Color.red);
    			else if(l.type.equals("replicate"))
    				g.setColor(Color.blue);
    			drawLine(rootpos, next);
    			drawTree(g, l.n,next ,size/100.0*45,dir);
    			
    		}
    	}
    	root.hasvited = false;
    	
    }
	
    
}
