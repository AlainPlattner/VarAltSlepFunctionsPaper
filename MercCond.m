function MercCond(wht,J)

  %wht = 'classical'
  %wht = 'acsf'
  %wht = 'vacsf'

  % Finds the eigenvalues of the matrix to solve for the coefficients

  rplanet = 2440;
  dom = [29,6];
  Lmax = 90;
   
  pct = 1;
  load(sprintf('synthdata_L%d_reducealt200_noise%dpct',Lmax,pct)); 

  Br = data(:,4);
  rad = data(:,1);
  theta = data(:,2);
  phi = data(:,3);
  clear data;

  switch wht
    case 'fix'
       rsat = rplanet + 500-200;
       [G,V]=glmalphaup(dom,Lmax,rsat,rplanet);

    case 'var'
       rsatfun = @MercRadVar_reducealt200;
       rsatfunsav = 'MercAltQuadFit2013MarApr_reducealt200';
       [G,V]=glmalphaupLatvar(dom,Lmax,rplanet,rsatfun,rsatfunsav,1);

    case 'classical'
      [G,V] = glmalpharing(dom,Lmax);

    otherwise
      error("please pick 'fix' or 'var' or 'classical' ")
  end

  parfor j=1:J
    M=rGscal(G(:,1:j),theta,phi,rad,rplanet,1);
    %MM = M*M';
    %condvals(j) = cond(MM);
    condvals(j) = cond(M);
    %j
    %Vinv = eig(MM);
    %Vinv = sort(Vinv,'descend');
  end
  
  savenameVinv=fullfile('gmt','data','MercInvCond',sprintf('Cond_%s_J%i.txt',wht,J));

  
  try
    writematrix([(1:length(condvals))',condvals'],savenameVinv, 'Delimiter', '\t')
  catch
    keyboard
  end
