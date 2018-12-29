clear;

gp.gen_distr = @(p1,p2) sum([p1,p2]);
gp.pl_growth = 0;
gp.pl_retract = 0;
gp.growth_p1 = 1;
gp.growth_p2 = 1;
gp.retract_p1 = 1;
gp.retract_p2 = 1;
gp.resource = 5000;
gp.bias = 0.7;
gp.g_factor = 0.4;
gp.r_factor = 0.8;
gp.version = 2;


data = generateFloret(gp)





