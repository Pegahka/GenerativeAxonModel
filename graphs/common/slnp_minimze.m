function ret = slnp_minimze(x)

    global points_all;
  
    
    ret = -sum(log(lognpdf(points_all - x(3), x(1), x(2))));
    
end