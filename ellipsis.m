function r = ellipsis(x)

  th = acos(x);
  
  a = 1.2;
  b = 1.3;
  xc = 0;
  yc = -0.25;

  r = 1./( ((sin(th)-xc)/a).^2 + ((cos(th)-yc)/b).^2 );


  
  %r = sqrt(b^2 - ((b/a)^2)*(x-xc).^2) +rc;

  %r = b/a*sqrt(a^2 - (x-coffset).^2) + altshift;
  %r = b/a*sqrt(a^2 - x.^2);
  %r = b*sqrt(1 - (x-offset).^2) + minalt;


  

  
  
