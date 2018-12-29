package floretgenerator;

import org.apache.commons.math3.distribution.*;

public class MathCommons {
    public static double bias = 0.1;
	public static double rShape = 400; 
	public static double rScale = 400;
	public static double growthSh = 20;
	public static double growthSc = 20;
	public static double retractSh = 6;
	public static double retractSc = 6;
	public static double offset = 1;
	public static double growthP = 0.9;
	public static double retractP = 0.0;
	public static double plGrowth = 0.0;
	public static double plRetract = 0.0;
	
	public static GammaDistribution growthGamma = new GammaDistribution(MathCommons.growthSh, MathCommons.growthSc);
	public static GammaDistribution retractGamma = new GammaDistribution(MathCommons.retractSh, MathCommons.retractSc);
	public static GammaDistribution resourceGamma = new GammaDistribution(MathCommons.rShape, MathCommons.rScale);
	public static UniformRealDistribution uniform = new UniformRealDistribution();
}
