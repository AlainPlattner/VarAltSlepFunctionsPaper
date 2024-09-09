function prepExperimentFigures(Lmax,alt)

  rplanet = 2440;

  % resolution for field plots
  res = 0.1;
  
  if alt
    altstr = '_reducealt200';
  else
    altstr = '';
  end

  %% Write out data locations and varying altitude
  
  % Write out lon,lat,rad for scatter, and lat,rad for varalt curve
  load(sprintf('synthdata_L90%s.mat',altstr))
  % Order of synth data
  % r, th, phi, Br, Bth, Bp
  points = [data(:,3)*180/pi,90-data(:,2)*180/pi,data(:,1)-rplanet];
  dlmwrite(fullfile('gmt','data',['dataloc',altstr,'.txt']),points);

  points = [90-data(:,2)*180/pi,data(:,1)-rplanet];
  dlmwrite(fullfile('gmt','data',['varalt',altstr,'.txt']),points);

  % Also create varalt curve
  theta = linspace(min(data(:,2)),max(data(:,2)),1000);
  x = cos(theta);
  lat = 90-theta*180/pi;
  if alt
    r = MercRadVar_reducealt200(x);
  else
    r = MercRadVar(x);
  end
  points = [lat(:),r(:)-rplanet];
  dlmwrite(fullfile('gmt','data',['varaltFunction',altstr,'.txt']),points);


  %% Export grided synthetic (true) model
  load(sprintf('synthcoef_L%d',Lmax));
  maxlat = 90; minlat = 50;
  region = [0,maxlat,360,minlat];
  [dat,lon,lat] = plm2xyz(coef2lmcosi(coef/sqrt(4*pi),0),res,region);
  grdwrite2p(lon,lat,dat,...
        fullfile('gmt','data',sprintf('potential_true_Lmax%d.nc',Lmax) ));  
  

  %% Export relative mse per J
  load(sprintf('localKernel_L%d',Lmax))
  msetrue =  calcmse(zeros(size(coef)),coef,K,Lmax);
  
  load(fullfile('savedSolutions',sprintf('manyJ-ACSF-Lmax%d-reducealt200-noise1pct.mat',Lmax)));
  [mi,in] = min(msevals);
  J
  bestJ = J(in)
  load(fullfile('savedSolutions',sprintf('ACSF-L%d-J%d-opt-reducealt200-noise1pct.mat',Lmax,bestJ)));
  coefACSF = coefInv; clear coefInv;
  dlmwrite(fullfile('gmt','data',sprintf('relativeMSE_ACSF_Lmax%d-bestJ%d.txt',Lmax,bestJ)),[J(:),msevals(:)/msetrue]);
  BESTrelmse = msevals(in)/msetrue

  load(fullfile('savedSolutions',sprintf('manyJ-VACSF-Lmax%d-reducealt200-noise1pct.mat',Lmax)));
  [mi,in] = min(msevals);
  J
  bestJ = J(in)
  load(fullfile('savedSolutions',sprintf('VACSF-L%d-J%d-opt-reducealt200-noise1pct.mat',Lmax,bestJ)));
  coefVACSF = coefInv; clear coefInv;
  dlmwrite(fullfile('gmt','data',sprintf('relativeMSE_VACSF_Lmax%d-bestJ%d.txt',Lmax,bestJ)),[J(:),msevals(:)/msetrue]);
  BESTrelmse = msevals(in)/msetrue


  load(fullfile('savedSolutions',sprintf('manyJ-Class-Lmax%d-reducealt200-noise1pct.mat',Lmax)));
  [mi,in] = min(msevals);
  J
  bestJ = J(in)
  load(fullfile('savedSolutions',sprintf('Class-L%d-J%d-opt-reducealt200-noise1pct.mat',Lmax,bestJ)));
  coefClass = coefInv; clear coefInv;
  dlmwrite(fullfile('gmt','data',sprintf('relativeMSE_Class_Lmax%d-bestJ%d.txt',Lmax,bestJ)),[J(:),msevals(:)/msetrue]);
  BESTrelmse = msevals(in)/msetrue


 
  %% Export grided inversion results and misfits
  [dat,lon,lat] = plm2xyz(coef2lmcosi(coefACSF/sqrt(4*pi),0),res,region);
  grdwrite2p(lon,lat,dat,fullfile('gmt','data',sprintf('ACSF_opt_Lmax%d.nc',Lmax) ));
  [dat,lon,lat] = plm2xyz(coef2lmcosi((coef-coefACSF)/sqrt(4*pi),0),res,region);
  grdwrite2p(lon,lat,dat,fullfile('gmt','data',sprintf('ACSF_err_Lmax%d.nc',Lmax) ));
  
  [dat,lon,lat] = plm2xyz(coef2lmcosi(coefVACSF/sqrt(4*pi),0),res,region);
  grdwrite2p(lon,lat,dat,fullfile('gmt','data',sprintf('VACSF_opt_Lmax%d.nc',Lmax) ));
  [dat,lon,lat] = plm2xyz(coef2lmcosi((coef-coefVACSF)/sqrt(4*pi),0),res,region);
  grdwrite2p(lon,lat,dat,fullfile('gmt','data',sprintf('VACSF_err_Lmax%d.nc',Lmax) ));

  [dat,lon,lat] = plm2xyz(coef2lmcosi(coefClass/sqrt(4*pi),0),res,region);
  grdwrite2p(lon,lat,dat,fullfile('gmt','data',sprintf('Class_opt_Lmax%d.nc',Lmax) ));
  [dat,lon,lat] = plm2xyz(coef2lmcosi((coef-coefClass)/sqrt(4*pi),0),res,region);
  grdwrite2p(lon,lat,dat,fullfile('gmt','data',sprintf('Class_err_Lmax%d.nc',Lmax) ));
