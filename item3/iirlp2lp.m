function [num, dem] = iirlp2lp(b,a,wo,wt)
    syms z;
    num_poly_init(z) = poly2sym(b,z);
    dem_poly_init(z) = poly2sym(a,z);

    alpha = sin((wo-wt)*pi/2)/sin((wo+wt)*pi/2);
    g = (z - alpha)/(1 - alpha*z);

    H = num_poly_init(g)/dem_poly_init(g);

    [num_poly,dem_poly] = numden(H);

    num = sym2poly(num_poly);
    dem = sym2poly(dem_poly);
end