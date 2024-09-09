function [V,lon,lat] = showSolutions(coef,showit)

  dom = [29,6];
  Lmax = 90;

  res = 0.2;

  region = [0,90-min(dom),360,90-max(dom)];
  lmcosi = coef2lmcosi(coef/sqrt(4*pi),0);
  [V,lon,lat] = plm2xyz(lmcosi,res,region);

  if showit
  imagesc(lon,lat,V);
  kelicol(1)
  caxis([-1,1]*max(abs(caxis)))
  axis xy
  xlabel('longitude')
  ylabel('latitude')
  colorbar
  end

%%%% Try showing radial field
  if false
  figure
  coef = vecupderivative(coef, 2440, 2440, Lmax);
  lmcosi = coef2lmcosi(coef/sqrt(4*pi),0);
  [B,lon,lat] = elm2xyz(lmcosi,res,region);

  
  imagesc(lon,lat,B{1});
  kelicol(1)
  caxis([-1,1]*max(abs(caxis)))
  axis xy
  xlabel('longitude')
  ylabel('latitude')
  colorbar
  end
