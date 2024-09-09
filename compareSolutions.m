function compareSolutions()

%%%% Loading
  load savedSolutions/ACSF-L120-J480-opt-reducealt200-noise1pct.mat
  invACSF = coefInv;

  load savedSolutions/VACSF-L120-J550-opt-reducealt200-noise1pct.mat
  invVACSF = coefInv;  

  clear coefInv
  
  load synthcoef_L120.mat


%%%% Calculating
  showit = false;

  [errA,lon,lat] = showSolutions(coef-invACSF,showit);
  errA = mean(abs(errA),2);

  [errV,lon,lat] = showSolutions(coef-invVACSF,showit);
  errV = mean(abs(errV),2);

  plot(lat,errA,'--')
  hold on
  plot(lat,errV,'-')
  plot(lat, errA-errV,'-.')

  % semilogy(lat,errA)
  % hold on
  % semilogy(lat,errV)
  % semilogy(lat, errA-errV)
  
  legend({'ACSF','VACSF','difference'})

  %figure
  %plot(lat, errA./errV)

  hold off

  
  
