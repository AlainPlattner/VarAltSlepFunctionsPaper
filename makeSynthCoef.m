function coef = makeSynthCoef(Lmax)

  %%%%%% In this example, assuming that coef is ADDMON %%%%%%
  
  rplanet = 2440;
  rsource = 2440; % 40 km depth
  
  % Create coefficient
  spec = SRD(rsource,rplanet,rplanet,Lmax,0);

  % Save coefficient
  [coefsO,coef] = createRandCoef(spec, Lmax, rplanet);

  %save(sprintf('synthcoef_L%d.mat',Lmax),'rsource','coef');

  % I commented the save out to not overwrite the coefficients when
  % accidentally running this function. If you do want to overwrite,
  % remove the XX.
