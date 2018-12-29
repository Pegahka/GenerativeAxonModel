package Draw;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.util.ArrayList;

import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JTextField;

import Draw.Drawers.ViewTreeDisplay;

public class MonitoringGui extends JFrame {

	private JPanel jxypane;
	private JTextField marking = new JTextField() ;
	public ArrayList<Drawer> drawers_applied = new ArrayList<Drawer>(); 
	public ArrayList<ExternalWindow> dialogs = new ArrayList<ExternalWindow>(); 
	private JMenu fileMenu;
	private JMenu editMenu;
	private JMenu optionsMenu;
	public Canvas2d component;
	private JMenu perspectiveMenu;
	private JMenu recording;

	private static MonitoringGui current;
	public static MonitoringGui getCurrent()
	{
		if(current ==null) current = getStandardGUI();
		return current;
	}

	public MonitoringGui() {
		current = this;
		//this.setLayout(new )
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.add(getMarking());
		this.add(drawboard());
		setTitle("Simple env ");
		setSize(500, 500);

		// Creates a menubar for a JFrame
		JMenuBar menuBar = new JMenuBar();

		// Add the menubar to the frame
		setJMenuBar(menuBar);

		// Define and add two drop down menu to the menubar
		fileMenu = new JMenu("Draw");
		editMenu = new JMenu("ShowDialog");
		optionsMenu = new JMenu("Options");
		perspectiveMenu = new JMenu("Perspective");
		recording = new JMenu("Video Recording");
		menuBar.add(fileMenu);
		menuBar.add(editMenu);
		menuBar.add(optionsMenu);
		menuBar.add(perspectiveMenu);
		menuBar.add(recording);
	

		




	}


	public JTextField getMarking() {

		marking.setPreferredSize(new Dimension(100,20));
		marking.setVisible(false);
		return marking;
	}

	public void addDialog(final ExternalWindow ew)
	{
		addDialog(ew,false);
	}

	public void addDialog(final ExternalWindow ew,boolean show)
	{
		JMenuItem newAction = new JMenuItem(ew.name);
		newAction.addActionListener(new ActionListener(){

			public void actionPerformed(ActionEvent e) {
				ew.setVisible(!ew.isVisible());
				if(ew.isVisible())
				{
					dialogs.add(ew);

					ew.addWindowListener(new WindowListener() {

						public void windowOpened(WindowEvent arg0) {
						}
						public void windowIconified(WindowEvent arg0) {}
						public void windowDeiconified(WindowEvent arg0) {}
						public void windowDeactivated(WindowEvent arg0) {}
						public void windowClosing(WindowEvent arg0) {if(!arg0.getWindow().isVisible()){							dialogs.remove(ew);}}
						public void windowClosed(WindowEvent arg0) {
						}
						public void windowActivated(WindowEvent arg0) {}
					});
				}else
				{
					dialogs.remove(ew);
				}
			}
		});
		if(show)
		{
			ew.setVisible(show);
			dialogs.add(ew);
		}
		editMenu.add(newAction);
	}

	public Rectangle getDrawingDimension()
	{
		return component.getBounds();
	}

	public void addDrawer(final Drawer d,boolean show)
	{
		final JMenuItem newAction = new JMenuItem(d.name);
		d.setCanvas(this.component);
		newAction.addActionListener(new ActionListener(){

			public void actionPerformed(ActionEvent arg0) {
				if(!drawers_applied.contains(d))
				{
					drawers_applied.add(d);
					d.added();
					newAction.setText(d.name+" *");
				}
				else
				{
					drawers_applied.remove(d);
					d.removed();
					newAction.setText(d.name);
				}
				
				MonitoringGui.this.repaint();
			}


		});
		if(show)
		{
			drawers_applied.add(d);
			d.added();
			newAction.setText(d.name+" *");
		}
		component.setDrawers_applied(drawers_applied);
		fileMenu.add(newAction);
	}

	
	private  boolean repaintdone = false;
	public boolean repaintdone()
	{
		if(repaintdone)
		{
			repaintdone = false;
			return true;
		}
		return false;
	}
	@Override
	public synchronized void paint(Graphics g)
	{
		try{
			super.paint(g);
			for (ExternalWindow i : dialogs) {
				if(i.isVisible())
				{
					i.updateWindow();
					i.repaint();
				}
			}

		}
		catch(Exception e){

		}
		repaintdone = true;
	}

	public JPanel drawboard() {
		if (jxypane == null) {
			component = new Canvas2d();

			jxypane = new JPanel();

			jxypane.setBackground(Color.white);
			jxypane.setPreferredSize(new Dimension(800,800));
			jxypane.setVisible(true);
			jxypane.setLayout(new BorderLayout());
			jxypane.add(marking,BorderLayout.NORTH);
			jxypane.add(component,BorderLayout.CENTER);

			ViewMouseListener m = new ViewMouseListener((Canvas2d)component);
			jxypane.addMouseMotionListener(m);
			jxypane.addMouseListener(m);
			jxypane.addMouseWheelListener(m);
			this.addKeyListener(m);
		}
		return jxypane;
	}

	public static MonitoringGui getStandardGUI()
	{
		MonitoringGui t = new MonitoringGui();
		
		
		t.component.setDrawers_applied(t.drawers_applied);
		t.setVisible(true);
		return t;
	}
	

	public synchronized void arrangeOnScreen(int x, int y, int w, int h) {
		this.setBounds(x, y, w, h);
		//		this.jxypane.setBounds(0, 0, w, h);
		//		this.component.setBounds(0, 0, w,h);
		int i = x;
		for (ExternalWindow k : dialogs) {
			k.arrangeWindow(i+w, y);
			i+=200;
		}
		component.setViewingSize(this.getWidth(), this.getHeight());
		this.setVisible(true);

	}


	public void setViewingSize720p()
	{
		component.getParent().setPreferredSize(new Dimension( 1280, 720));
		component.setViewingSize( 1280, 720);
		this.setBounds(0,0,1280, 720+40);
	}
	
	public void setViewingSize1080p()
	{
		component.getParent().setPreferredSize(new Dimension(1920, 1080));
		component.setViewingSize( 1920, 1080);
		this.setBounds(0,0,1920, 1080+40);
	}
	
	public void setViewingSizePal()
	{
		component.getParent().setPreferredSize(new Dimension(640,480));
		component.setViewingSize( 640, 480);
		this.setBounds(0,0,640,480+40);
	}


}