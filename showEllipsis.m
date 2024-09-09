function showEllipsis()

  % To make sure that I have a sensible orbit: Plot on sphere

  clf

  rplanet = 6371;
  
  res = 1;
  lon = 0:res:360;
  cola = 0:res:180;
  [LO,CO] = meshgrid(lon,cola);

  x = cos(CO*pi/180);
  r = ellipsisEarthS(x);

  
  subplot(3,1,1)
  plotplm(r-rplanet,lon*pi/180,(90-cola)*pi/180,4,1);
  colorbar


  
  subplot(3,1,2)
  x = cos(cola*pi/180);
  r = ellipsisEarthS(x);
  plot(90-cola,r-rplanet)
  XY = africa(); latA = XY(:,2);
  hold on
  minLatAr = ellipsisEarthS(cos(pi/180*(90-min(latA))))-rplanet
  plot([min(latA),min(latA)],[0,minLatAr])
  maxLatAr = ellipsisEarthS(cos(pi/180*(90-max(latA))))-rplanet
  plot([max(latA),max(latA)],[0,maxLatAr])
  

  
  subplot(3,1,3) 
  r = ellipsisEarthS(cos(cola*pi/180));
  [x,y] = pol2cart(cola*pi/180,r);  
  plot(x,y,'b')
  hold on
  plot(x,-y,'b')
  
  % rp = ellipsis(cos(-cola*pi/180));
  % [xp,yp] = pol2cart(-cola*pi/180,r);
  % plot(xp,yp,'b')

  
  [xc,yc] = pol2cart(cola*pi/180,rplanet*ones(size(cola)));
  plot(xc,yc,'k')
  plot(xc,-yc,'k')
  axis equal
  axis tight

%%% Write trajectory ellipsis and Earth radius
  writematrix([y(:),x(:);-flipud(y(:)),flipud(x(:))], fullfile('gmt/data/orbit.txt'))
  %%% Also write out the unit sphere
  writematrix([yc(:),xc(:);-flipud(yc(:)),flipud(xc(:))], fullfile('gmt/data/Earth.txt'))
  


