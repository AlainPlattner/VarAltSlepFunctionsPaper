function enrg = MercEnergyInside(J)

  rplanet = 2440;
  dom = [29,6];
  Lmax = 90;

  [Gc,Vc] = glmalpharing(dom,Lmax);

  K = Gc*diag(Vc)*Gc';


  rsatfun = @MercRadVar_reducealt200;
  rsatfunsav = 'MercAltQuadFit2013MarApr_reducealt200';
  [G,V]=glmalphaupLatvar(dom,Lmax,rplanet,rsatfun,rsatfunsav,1);

  for j=1:J
    enrg(j) = G(:,j)'*K*G(:,j);
  end
  
