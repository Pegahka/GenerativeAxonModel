package floretgenerator;

import segmentexporter.Segment;
import ini.cx3d.Param;
import ini.cx3d.localBiology.CellElement;
import ini.cx3d.localBiology.LocalBiologyModule;
import ini.cx3d.localBiology.NeuriteElement;
import static ini.cx3d.utilities.Matrix.dot;
import static ini.cx3d.utilities.Matrix.normalize;
import static ini.cx3d.utilities.Matrix.norm;
import static ini.cx3d.utilities.Matrix.add;
import static ini.cx3d.utilities.Matrix.randomNoise;



public class Floret implements LocalBiologyModule {
	NeuriteElement neuriteElement;	
	private double resource;
	private String substanceId;
	private Boolean first = true;
	private double speedBooster = 1.0/Param.SIMULATION_TIME_STEP;
	private double randomnessWeight = 1.0; 
	
	private double[] direction;
	private double[] gradientDirection;
	
	private Segment segment;
	
	public Floret(double resource, Segment segment, String substanceId) {
		this.substanceId = substanceId;
		this.segment = segment;			
		this.resource = resource;
	}	
	
	public void setResource(int resource) {
		this.resource = resource;
	}
	
	public double getResource() {
		return resource;
	}
	
	public CellElement getCellElement() {
		return neuriteElement;
	}

	public void setCellElement(CellElement cellElement) {
		if(cellElement.isANeuriteElement()){
			neuriteElement = (NeuriteElement)cellElement;
			direction = neuriteElement.getPhysicalCylinder().getAxis();
		}else{
			cellElement.removeLocalBiologyModule(this);
			System.out.println("Sorry, I only work with neurite elements");
		}
	}
	
	public LocalBiologyModule getCopy() {
		return null;
	}

	public boolean isCopiedWhenNeuriteBranches() {
		return false;
	}

	public boolean isCopiedWhenNeuriteElongates() {
		return false;	// only in growth cones
	}

	public boolean isCopiedWhenNeuriteExtendsFromSoma() {
		return false;	// this method should never be called
	}

	public boolean isCopiedWhenSomaDivides() {
		return false;  	// this method should never be called
	}
	
	public boolean isDeletedAfterNeuriteHasBifurcated() {
		return true;	// Important because of bifurcations!
	}

	public void run() {
		gradientDirection = normalize(this.getCellElement().getPhysical().getExtracellularGradient(substanceId));			
		if (this.first) {
			System.out.println("first growth cycle");
			this.first = false;
			double length = MathCommons.offset + MathCommons.plGrowth + MathCommons.growthGamma.sample();
			double speed = length;			
			
			for (int i = 1; i < speedBooster; i++) {				
				neuriteElement.getPhysicalCylinder().movePointMass(speed, normalize(add(direction, randomNoise(randomnessWeight,3))));
			}
			
			segment.elongate(length);
			resource--;
		}		
		
		if (resource >= 1) {			
			
			if (MathCommons.uniform.sample() < MathCommons.growthP) {
				resource--;
				System.out.println("growth");
				double length = MathCommons.plGrowth + MathCommons.growthGamma.sample();
				double speed = length;
				
				for (int i = 1; i < speedBooster; i++) {				
					neuriteElement.getPhysicalCylinder().movePointMass(speed, normalize(add(direction, randomNoise(randomnessWeight,3))));
				}								
				
				segment.elongate(length);
			} else if (MathCommons.uniform.sample() < MathCommons.retractP) {
				System.out.println("retraction");
				double speed = MathCommons.plRetract + MathCommons.retractGamma.sample() * speedBooster;
				//if (neuriteElement.getPhysicalCylinder().getActualLength() )
				if (!(neuriteElement.getPhysicalCylinder().retractCylinder(speed))) {
					//full retraction;					
					neuriteElement.cleanAllLocalBiologyModules();
				};
				segment.retract(speed * Param.SIMULATION_TIME_STEP);
			} else {							
				
				double rl = 1;
				double rr = 1;

				double bias = norm(this.getCellElement().getPhysical().getExtracellularGradient(substanceId));
				bias = bias + MathCommons.uniform.sample() * (1 - bias);				
				
				if (resource >= 2) {
					System.out.println(bias);
					rl = rl + (resource - 2) * bias;
					rr = rr + (resource - 2) * (1 - bias);
					
					NeuriteElement[] nn = neuriteElement.bifurcate();
					
					double dotLeft = dot(normalize(nn[0].getPhysicalCylinder().getAxis()), normalize(gradientDirection));
					double dotRight = dot(normalize(nn[1].getPhysicalCylinder().getAxis()), normalize(gradientDirection));
					
					Segment segmentLeft = new Segment(); segment.setLeft(segmentLeft);
					Segment segmentRight = new Segment(); segment.setRight(segmentRight);
					
					if (dotLeft > dotRight) {
						nn[0].getPhysical().setColor(Param.GREEN);
						nn[0].addLocalBiologyModule(new Floret(rl, segmentLeft, substanceId));
						nn[1].getPhysical().setColor(Param.RED);										
						nn[1].addLocalBiologyModule(new Floret(rr, segmentRight, substanceId));
					} else {
						nn[1].getPhysical().setColor(Param.GREEN);
						nn[1].addLocalBiologyModule(new Floret(rl, segmentLeft, substanceId));
						nn[0].getPhysical().setColor(Param.RED);										
						nn[0].addLocalBiologyModule(new Floret(rr, segmentRight, substanceId));					
					}
				} else {
					System.out.println("Resource consumed");
					neuriteElement.cleanAllLocalBiologyModules();
				}
			}
		} else {
		
			System.out.println("Resource consumed");
			neuriteElement.cleanAllLocalBiologyModules();
		}
	}
}
