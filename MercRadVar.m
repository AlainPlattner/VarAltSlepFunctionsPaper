function r = MercRadVar(x)
  % Input x is cos(colatitude); It is 1 at North Pole and -1 at South Pole
  
  % Obtained from
  p = 1.0e+03*[0.2489,-1.6306,4.2666];

  r = polyval(p,x);
