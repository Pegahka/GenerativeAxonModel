package Draw;
import java.awt.Component;
import java.awt.Graphics;
import java.io.Serializable;
import java.util.ArrayList;




public class Canvas2d extends Component implements Serializable{

	public static double basescale = 20;
	public int width  = 500;
	public int centerx;
	public int height = 500;
	public int centery;
	private ArrayList<Drawer> drawers_applied;
	protected double scale = basescale;

	private double alphaAroundX;
	private double alphaAroundY;


	public void resetView()
	{
		centerx=0;
		centery =0;
		scale = basescale;
	}

	public Canvas2d()
	{

	}

	@Override
	public void paint(Graphics g)
	{
		try{
			synchronized (g) {
				super.paint(g);
				for (Drawer d : drawers_applied) {
					d.paint(g);
				}
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}


	public void setCenterx(int centerx) {
		this.centerx = centerx;
	}

	public int getCenterx() {
		return centerx;
	}

	public void setCentery(int centery) {
		this.centery = centery;
	}

	public int getCentery() {
		return centery;
	}

	public void setScale(double scale) {
		this.scale = scale;
	}

	public double getScale() {
		return scale;
	}


	public void setViewingSize(int width, int height)
	{
		this.width = width;
		this.height = height;

	}

	public void setDrawers_applied(ArrayList<Drawer> drawers_applied) {
		this.drawers_applied = drawers_applied;
	}

	public ArrayList<Drawer> getDrawers_applied() {
		return drawers_applied;
	}

}
