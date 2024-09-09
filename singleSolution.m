function coefInv = singleSolution(wht,J)

  %wht = 'acsf'
  %wht = 'vacsf'



  
  rplanet = 2440;
  
  dom = [29,6];
  Lmax = 90;

  load(sprintf('synthdata_L%d_reducealt200_noise1pct.mat',Lmax))

  if strcmp(wht,'acsf')
    
%%% need to find optimal J
    %sf = 1.2
    %J = round(sf*spharea(max(dom),1)*(Lmax+1)^2);
    
    % Solve using LocalIntField
    Br = data(:,4);
    rad = data(:,1);
    theta = data(:,2);
    phi = data(:,3);
    rsat = rplanet + 500-200;
    % Average altitude is 498. Make it an easy number
    
    coefInv = LocalIntField(Br, rad, theta, phi, dom, Lmax, J, rplanet, rsat);

  elseif strcmp(wht,'vacsf')

    %sf = 1.2
    %J = round(sf*spharea(max(dom),1)*(Lmax+1)^2);
    
    % Solve using LocalIntField
    Br = data(:,4);
    rad = data(:,1);
    theta = data(:,2);
    phi = data(:,3);
    %rsatfun = @MercRadVar;
    %rsatfunsav = 'MercAltQuadFit2013MarApr';
    rsatfun = @MercRadVar_reducealt200;
    rsatfunsav = 'MercAltQuadFit2013MarApr_reducealt200';
    
    coefInv = LocalIntFieldLatvar(Br, rad, theta, phi, dom, Lmax, J, rplanet, rsatfun,rsatfunsav);


  elseif strcmp(wht,'classical')

    Br = data(:,4);
    rad = data(:,1);
    theta = data(:,2);
    phi = data(:,3);
    
    coefInv = LocalIntFieldClassical(Br, rad, theta, phi, dom, Lmax, J, rplanet);
    
  end
