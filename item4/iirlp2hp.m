function [num, dem] = iirlp2hp(b,a,wo,wt)
    syms z;
    num_poly_init(z) = poly2sym(b,z);
    dem_poly_init(z) = poly2sym(a,z);

    alpha = cos((wt+wo)*pi/2)/cos((wt-wo)*pi/2);
    if alpha < 1e-7
        alpha = 0; % caso alfa seja muito pequeno, considere nulo
    end
    g = -(z - alpha)/(1 - alpha*z);

    H = num_poly_init(g)/dem_poly_init(g);

    [num_poly,dem_poly] = numden(H);

    num = sym2poly(num_poly);
    dem = sym2poly(dem_poly);
end