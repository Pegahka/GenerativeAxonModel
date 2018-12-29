package Draw;
import java.io.Serializable;
import java.util.ArrayList;





public class Vector2d implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4403248450307788344L;
	private double x;
	private double y;
	
	


	public Vector2d(double x, double y)
	{
		this.setX(x);
		this.setY(y);
	}
	
	public Vector2d(double [] v)
	{
		this.setX(v[0]);
		this.setY(v[1]);
	}

	public void setY(double y) {
		this.y = y;
	}

	public double getY() {
		return y;
	}

	public void setX(double x) {
		this.x = x;
	}

	public double getX() {
		return x;
	}
	
	public Vector2d scalarMult(double s)
	{
		Vector2d temp = new Vector2d(x,y);
		temp.x*=s;
		temp.y*=s;
		return temp;
	}
	
	public Vector2d minus(Vector2d a)
	{
		Vector2d temp = new Vector2d(x,y);
		temp.x-=a.x;
		temp.y-=a.y;
		return temp;
	}
	
	public Vector2d plus(Vector2d a)
	{
		Vector2d temp = new Vector2d(x,y);
		temp.x+=a.x;
		temp.y+=a.y;
		return temp;
	}
	
	public double length()
	{
		return Math.sqrt(x*x+y*y);
	}
	
	public Vector2d Normalize()
	{
		Vector2d temp = new Vector2d(x,y);
		double length = temp.length();
		temp.x/=length;
		temp.y/=length;
		return temp;
	}
	
	public double [] toArray()
	{
		return new double[] {x,y};
	}

	
	public String toString()
	{
		return "("+x+ ","+y+")";
	}

	public Vector2d mult(double d) {
		Vector2d temp = new Vector2d(x,y);
		temp.x*=d;
		temp.y*=d;
		return temp;
	}

	public double disance(Vector2d a) {
		double x = this.x-a.x;
		double y = this.y-a.y;
		return Math.sqrt(x*x+y*y);
	}
	

	public static Vector2d sum(ArrayList<Vector2d> c)
	{
		Vector2d d = new Vector2d(0,0); 
		for(Vector2d v:c)
		{
			d.x+=v.x;
			d.y+=v.y;
		}
		return d;
		
	}
	
	public static Vector2d average(ArrayList<Vector2d> c)
	{
		Vector2d d = sum(c);
		d  = d.mult(1.0/c.size());
		return d;
	}

	public void setVect(Vector2d vect) {
		this.x = vect.x;
		this.y = vect.y;
		
	}

	
}
