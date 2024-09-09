function [msevals,J] = findBestJ(wht)
  
  %wht = 'acsf'
  %wht = 'vacsf'
  
  rplanet = 2440;
  dom = [29,6];

  %Lmax = 60;
  Lmax = 90;
  
  %sf = 0.3:0.01:1.2;
  %J = round(sf*(spharea(max(dom),1)-spharea(min(dom),1))*(Lmax+1)^2)
  %J = 150:5:600; % THis is the right one for Lmax90 and altcog

  J = 5:5:450; % Trying this for classical Lmax90 

  %J = 300:10:700;
  %J = 250:5:500;

  
  pct = 1;
  load(sprintf('synthdata_L%d_reducealt200_noise%dpct',Lmax,pct)); 

  Br = data(:,4);
  rad = data(:,1);
  theta = data(:,2);
  phi = data(:,3);
  clear data;


  % Initialize
  msevals = nan(length(J),1);
  
  if strcmp(wht,'acsf')

    %rsat = rplanet + 500;
    % Average altitude is 498. Make it an easy number
    %%%% Lower altitude
    rsat = rplanet + 500-200;
    i=1;
    coefInv{i} = LocalIntField(Br, rad, theta, phi, dom, Lmax, J(i), rplanet, rsat);
    parfor i=2:length(J)
      coefInv{i} = LocalIntField(Br, rad, theta, phi, dom, Lmax, J(i), rplanet, rsat);
    end
    
    

    
  elseif strcmp(wht,'vacsf')
    
    rsatfun = @MercRadVar_reducealt200;
    rsatfunsav = 'MercAltQuadFit2013MarApr_reducealt200';

    i=1;
    coefInv{i} = LocalIntFieldLatvar(Br, rad, theta, phi, dom, Lmax, J(i), rplanet, rsatfun,rsatfunsav);
    parfor i=2:length(J)
      coefInv{i} = LocalIntFieldLatvar(Br, rad, theta, phi, dom, Lmax, J(i), rplanet, rsatfun,rsatfunsav);
    end

  elseif strcmp(wht,'classical')
    
    i=1;
    coefInv{i} = LocalIntFieldClassical(Br, rad, theta, phi, dom, Lmax, J(i), rplanet);
    parfor i=2:length(J)
      coefInv{i} = LocalIntFieldClassical(Br, rad, theta, phi, dom, Lmax, J(i), rplanet);
    end
    
  end


%%% RSE
  
  try
% For safety in case something is bad
    
  % Now get mse
  cf = load(sprintf('synthcoef_L%d.mat',Lmax));
  kn = load(sprintf('localKernel_L%d.mat',Lmax));
  for i=1:length(J)
      msevals(i) = calcmse(coefInv{i},cf.coef,kn.K);
  end

  catch
    keyboard

  end
