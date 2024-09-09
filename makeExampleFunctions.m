function makeExampleFunctions()

  showit = false
  res = 0.5; % for GMT
  
  Lmax = 60;
  ind1 = 1;
  ind2 = 100;
  ind3 = 200;

  dom = 'africa';
  rplanet = 6371;
  XY = africa(); lat = XY(:,2); lats = min(lat):max(lat);
  r = ellipsisEarthS(cos((90-lats)*pi/180));
  avgsat = round(mean(r));
  rsatfun = @ellipsisEarthS;
  rsatfunsav = 'ellipsisEarthS';
  

  
  % Classical Slepian function
  [Gc,Vc] = glmalpha(dom, Lmax);

  % Altitude cognizant
  [Ga,Va] = glmalphaup(dom,Lmax,avgsat,rplanet);

  % Varying altitude cognizant
  [Gv,Vv] = glmalphaupLatvar(dom,Lmax,rplanet,rsatfun,rsatfunsav,1);


  % Write out eigenvalues
  filename = fullfile('gmt','data',sprintf('Classical_L%d_eigenvals.txt',Lmax));
  writematrix([(1:length(Vc))',Vc(:)],filename)
  
  filename = fullfile('gmt','data',sprintf('AltCog_L%d_eigenvalues.txt',Lmax));
  writematrix([(1:length(Va))',Va(:)],filename)
  
  filename = fullfile('gmt','data',sprintf('VarAltCog_L%d_eigenvalues.txt',Lmax));
  writematrix([(1:length(Vv))',Vv(:)],filename)
  

  % Write them out for GMT
  [dat,lon,lat] = plm2xyz(coef2lmcosi(Gc(:,ind1)/sqrt(4*pi),1),res);%,region);
  dat = dat/max(abs(dat(:)));
  filename = fullfile('gmt','data',sprintf('Classical_L%d_ind%d.nc',Lmax,ind1)) ; 
  grdwrite2p(lon,lat,dat,filename);

  [dat,lon,lat] = plm2xyz(coef2lmcosi(Gc(:,ind2)/sqrt(4*pi),1),res);%,region);
  filename = fullfile('gmt','data',sprintf('Classical_L%d_ind%d.nc',Lmax,ind2)) ;
  dat = dat/max(abs(dat(:)));
  grdwrite2p(lon,lat,dat,filename);

  [dat,lon,lat] = plm2xyz(coef2lmcosi(Gc(:,ind3)/sqrt(4*pi),1),res);%,region);
  filename = fullfile('gmt','data',sprintf('Classical_L%d_ind%d.nc',Lmax,ind3)) ;
  dat = dat/max(abs(dat(:)));
  grdwrite2p(lon,lat,dat,filename);


  [dat,lon,lat] = plm2xyz(coef2lmcosi(Ga(:,ind1)/sqrt(4*pi),1),res);%,region);
  filename = fullfile('gmt','data',sprintf('AltCog_L%d_ind%d.nc',Lmax,ind1)) ;
  dat = dat/max(abs(dat(:)));
  grdwrite2p(lon,lat,dat,filename);

  [dat,lon,lat] = plm2xyz(coef2lmcosi(Ga(:,ind2)/sqrt(4*pi),1),res);%,region);
  dat = dat/max(abs(dat(:)));
  filename = fullfile('gmt','data',sprintf('AltCog_L%d_ind%d.nc',Lmax,ind2)) ; 
  grdwrite2p(lon,lat,dat,filename);

  [dat,lon,lat] = plm2xyz(coef2lmcosi(Ga(:,ind3)/sqrt(4*pi),1),res);%,region);
  dat = dat/max(abs(dat(:)));
  filename = fullfile('gmt','data',sprintf('AltCog_L%d_ind%d.nc',Lmax,ind3)) ; 
  grdwrite2p(lon,lat,dat,filename);


  [dat,lon,lat] = plm2xyz(coef2lmcosi(Gv(:,ind1)/sqrt(4*pi),1),res);%,region);
  dat = dat/max(abs(dat(:)));
  filename = fullfile('gmt','data',sprintf('VarAltCog_L%d_ind%d.nc',Lmax,ind1)) ; 
  grdwrite2p(lon,lat,dat,filename);

  [dat,lon,lat] = plm2xyz(coef2lmcosi(Gv(:,ind2)/sqrt(4*pi),1),res);%,region);
  dat = dat/max(abs(dat(:)));
  filename = fullfile('gmt','data',sprintf('VarAltCog_L%d_ind%d.nc',Lmax,ind2)) ; 
  grdwrite2p(lon,lat,dat,filename);

  [dat,lon,lat] = plm2xyz(coef2lmcosi(Gv(:,ind3)/sqrt(4*pi),1),res);%,region);
  dat = dat/max(abs(dat(:)));
  filename = fullfile('gmt','data',sprintf('VarAltCog_L%d_ind%d.nc',Lmax,ind3)) ; 
  grdwrite2p(lon,lat,dat,filename);
  
  

  if showit
  subplot(3,3,1)
  plotplm(coef2lmcosi(Gc(:,ind1),1),[],[],2,1);
  kelicol(1)
  caxis([-1,1]*max(abs(caxis)))
  
  subplot(3,3,4)
  plotplm(coef2lmcosi(Gc(:,ind2),1),[],[],2,1);
  kelicol(1)
  caxis([-1,1]*max(abs(caxis)))

  subplot(3,3,7)
  plotplm(coef2lmcosi(Gc(:,ind3),1),[],[],2,1);
  kelicol(1)
  caxis([-1,1]*max(abs(caxis)))  

  
  subplot(3,3,2)
  plotplm(coef2lmcosi(Ga(:,ind1),1),[],[],2,1);
  kelicol(1)
  caxis([-1,1]*max(abs(caxis)))
 
  subplot(3,3,5)
  plotplm(coef2lmcosi(Ga(:,ind2),1),[],[],2,1);
  kelicol(1)
  caxis([-1,1]*max(abs(caxis)))

  subplot(3,3,8)
  plotplm(coef2lmcosi(Ga(:,ind3),1),[],[],2,1);
  kelicol(1)
  caxis([-1,1]*max(abs(caxis)))
         
  
  subplot(3,3,3)
  plotplm(coef2lmcosi(Gv(:,ind1),1),[],[],2,1);
  kelicol(1)
  caxis([-1,1]*max(abs(caxis)))
  
  subplot(3,3,6)
  plotplm(coef2lmcosi(Gv(:,ind2),1),[],[],2,1);
  kelicol(1)
  caxis([-1,1]*max(abs(caxis)))
  
  subplot(3,3,9)
  plotplm(coef2lmcosi(Gv(:,ind3),1),[],[],2,1);
  kelicol(1)
  caxis([-1,1]*max(abs(caxis)))
  end
