package Draw;


import java.awt.Graphics;
import java.io.Serializable;



public abstract class Drawer implements Serializable{
	public String name;
	private Canvas2d c;
	private transient Graphics g;

	public abstract void draw(Graphics g);

	public void added()
	{

	}

	public void removed()
	{}

	public void setCanvas(Canvas2d c) {
		this.c = c;
	}


	public synchronized void paint(Graphics g)
	{
		this.g = g;
		draw(g);
	}

	protected void drawLine(Vector2d start, Vector2d end)
	{

	
		int x1 = 0,x2=0,y1=0,y2=0;
		x1 = (int)(start.getX()*c.getScale());
		y1 = (int)(start.getY()*c.getScale());
		x2 = (int)(end.getX()*c.getScale());
		y2 = (int)(end.getY()*c.getScale());
		
		x1 = x1+c.width/2-c.getCenterx();
		x2 = x2+c.width/2-c.getCenterx();
		y1 =  -(y1-c.height/2)-c.getCentery();
		y2 = -(y2-c.height/2)-c.getCentery();
		
		g.drawLine(x1,y1,x2 ,y2 );
	}

	protected void drawLine(Vector2d start, Vector2d end,double thickness)
	{
		thickness *=c.getScale();
	
		int x1 = 0,x2=0,y1=0,y2=0;
		x1 = (int)(start.getX()*c.getScale());
		y1 = (int)(start.getY()*c.getScale());
		x2 = (int)(end.getX()*c.getScale());
		y2 = (int)(end.getY()*c.getScale());

		this.drawThickLine(g, (x1+c.width/2)-c.getCenterx(),
				-(y1-c.height/2)-c.getCentery(),
				x2+c.width/2-c.getCenterx(),
				-(y2-c.height/2)-c.getCentery(),(int)thickness
		);
	}

	protected void drawRect(Vector2d start, Vector2d end)
	{

		int x1 = 0,x2=0,y1=0,y2=0;
		x1 = (int)(start.getX()*c.getScale());
		y1 = (int)(start.getY()*c.getScale());
		x2 = (int)(end.getX()*c.getScale());
		y2 = (int)(end.getY()*c.getScale());
		int x = Math.min(x1, x2);
		int y = Math.max(y1, y2);

		g.drawRect(x+c.width/2-c.getCenterx(), -(y-c.height/2)-c.getCentery(), Math.abs(x1-x2), Math.abs(y1-y2));
	}


	protected void fillRect(Vector2d start, Vector2d end)
	{

		int x1 = 0,x2=0,y1=0,y2=0;
		x1 = (int)(start.getX()*c.getScale());
		y1 = (int)(start.getY()*c.getScale());
		x2 = (int)(end.getX()*c.getScale());
		y2 = (int)(end.getY()*c.getScale());
		int x = Math.min(x1, x2);
		int y = Math.max(y1, y2);

		g.fillRect(x+c.width/2-c.getCenterx(), -(y-c.height/2)-c.getCentery(), Math.abs(x1-x2), Math.abs(y1-y2));
	}

	protected void drawOval(Vector2d start, Vector2d end)
	{

		int x1 = 0,x2=0,y1=0,y2=0;
		x1 = (int)(start.getX()*c.getScale());
		y1 = (int)(start.getY()*c.getScale());
		x2 = (int)(end.getX()*c.getScale());
		y2 = (int)(end.getY()*c.getScale());
		int x = Math.min(x1, x2);
		int y = Math.max(y1, y2);

		g.drawOval(x+c.width/2-c.getCenterx(), -(y-c.height/2)-c.getCentery(), Math.abs(x1-x2), Math.abs(y1-y2));
	}

	protected void fillOval(Vector2d start, Vector2d end)
	{

		int x1 = 0,x2=0,y1=0,y2=0;

		x1 = (int)(start.getX()*c.getScale());
		y1 = (int)(start.getY()*c.getScale());
		x2 = (int)(end.getX()*c.getScale());
		y2 = (int)(end.getY()*c.getScale());
		int x = Math.min(x1, x2);
		int y = Math.max(y1, y2);

		g.fillOval(x+c.width/2-c.getCenterx(), -(y-c.height/2)-c.getCentery(), Math.abs(x1-x2), Math.abs(y1-y2));
	}

	protected void drawCyrcle(Vector2d start,double radius)
	{
		int x1 = 0,x2=0,y1=0,y2=0;
		radius = Math.max(radius*c.getScale(),2);

		x1 = (int)(start.getX()*c.getScale()-radius);
		y1 = (int)(start.getY()*c.getScale()-radius);
		x2 = (int)(start.getX()*c.getScale()+radius);
		y2 = (int)(start.getY()*c.getScale()+radius);
		int x = Math.min(x1, x2);
		int y = Math.max(y1, y2);

		g.fillOval(x+c.width/2-c.getCenterx(), -(y-c.height/2)-c.getCentery(), Math.abs(x1-x2), Math.abs(y1-y2));
	}
	
	protected void drawCyrcleUnsacaled(Vector2d start,double radius)
	{
		int x1 = 0,x2=0,y1=0,y2=0;
	
		x1 = (int)(start.getX()*c.getScale()-radius/2);
		y1 = (int)(start.getY()*c.getScale()-radius/2);
		x2 = (int)(start.getX()*c.getScale()+radius/2);
		y2 = (int)(start.getY()*c.getScale()+radius/2);
		int x = Math.min(x1, x2);
		int y = Math.max(y1, y2);

		g.fillOval(x+c.width/2-c.getCenterx(), -(y-c.height/2)-c.getCentery(), Math.abs(x1-x2), Math.abs(y1-y2));
	}
	
	protected void drawCyrcle(Vector2d start,double radius,int offsetx)
	{
		int x1 = 0,x2=0,y1=0,y2=0;
		radius = Math.max(radius*c.getScale(),2);
	
		x1 = (int)(start.getX()*c.getScale()-radius/2);
		y1 = (int)(start.getY()*c.getScale()-radius/2);
		x2 = (int)(start.getX()*c.getScale()+radius/2);
		y2 = (int)(start.getY()*c.getScale()+radius/2);
		int x = Math.min(x1, x2);
		int y = Math.max(y1, y2);

		g.fillOval(x+c.width/2-c.getCenterx()+offsetx, -(y-c.height/2)-c.getCentery(), Math.abs(x1-x2), Math.abs(y1-y2));
	}

	protected void drawString(Vector2d start,String str)
	{
		
		int x = (int)(start.getX()*c.getScale());
		int y = (int)(start.getY()*c.getScale());

		g.drawString(str, x+c.width/2-c.getCenterx(), -(y-c.height/2)-c.getCentery());
	}
	
	
	protected void drawChar(Vector2d start,char chr)
	{
		
		int x = (int)(start.getX()*c.getScale());
		int y = (int)(start.getY()*c.getScale());

		g.drawString(chr+"", x+c.width/2-c.getCenterx()-4, -(y-c.height/2-4)-c.getCentery());
	}

	private void drawThickLine(Graphics g, int x1, int y1, int x2, int y2, int thickness) {
		// The thick line is in fact a filled polygon
		int dX = x2 - x1;
		int dY = y2 - y1;
		// line length
		double lineLength = Math.sqrt(dX * dX + dY * dY);

		double scale = (double)(thickness) / (2 * lineLength);

		// The x,y increments from an endpoint needed to create a rectangle...
		double ddx = -scale * (double)dY;
		double ddy = scale * (double)dX;
		ddx += (ddx > 0) ? 0.5 : -0.5;
		ddy += (ddy > 0) ? 0.5 : -0.5;
		int dx = (int)ddx;
		int dy = (int)ddy;

		// Now we can compute the corner points...
		int xPoints[] = new int[4];
		int yPoints[] = new int[4];

		xPoints[0] = x1 + dx; yPoints[0] = y1 + dy;
		xPoints[1] = x1 - dx; yPoints[1] = y1 - dy;
		xPoints[2] = x2 - dx; yPoints[2] = y2 - dy;
		xPoints[3] = x2 + dx; yPoints[3] = y2 + dy;

		g.fillPolygon(xPoints, yPoints, 4);
	}


	
}
