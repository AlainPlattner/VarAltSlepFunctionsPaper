function msqe = crudemse(coefInv, coef)

  % Calculates a crude mean square error by summing up evaluated difference
  % of points in region

  dom = [29,6];
  %dom = [25,6];
  region = [0,90-min(dom),360,90-max(dom)];
  
  lmcosi = coef2lmcosi((coef-coefInv)/sqrt(4*pi),0);
  r = plm2xyz(lmcosi,1,region);

  msqe = mean( r(:).^2 );
  
