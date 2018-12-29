package segmentexporter;

public class Segment {	
	private double length;	
	
	private Segment parent = null;
	private Segment left = null;
	private Segment right = null;
	
	public Segment getParent() {
		return parent;
	}
	
	public void setParent(Segment parent) {
		this.parent = parent;
	}
	
	public void setLeft(Segment left) {
		if (left != null)
			left.setParent(this);		
		this.left = left;	
	}
	
	public void setRight(Segment right) {
		if (right != null)
			right.setParent(this);
		this.right = right;
	}
	
	public Segment getLeft() {
		return left;
	}
	
	public Segment getRight() {
		return right;
	}
	
	public Segment getSibling() {
		if (this.parent != null) {
			if (this == parent.getLeft()) 
				return parent.getRight();
			else 
				return parent.getLeft();
		}
		
		return null;
	}
	
	public Segment(double length) {		
		this.length = length;
	}
	
	public Segment() {		
		length = 0.0;
	}	
	
	public double getLength() {
		return length;
	}
	
	public void setLength(double length) {
		this.length = length;
	}
	
	public void elongate(double length) {
		this.length += length;
	}
	
	public void retract(double length) {
		this.length -= length;
	}
}
