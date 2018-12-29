gp.gen_distr = @(p1,p2) gamrnd(p1,p2);
gp.pl_growth = 5;
gp.pl_retract = 3;
gp.growth_p1 = 4;
gp.growth_p2 = 4;
gp.retract_p1 = 0;
gp.retract_p2 = 0;
gp.resource = 100;
gp.bias = 0.5;
gp.g_factor = 0.4;
gp.r_factor = 0;
gp.version = 2;

gp.no_florets = 500;

floret = generateMultipleFlorets(gp);
