function makeSynthData(Lmax)

  maxalt = 600;
  rplanet = 2440;
  minlat = 61;

  reducealt = 200;
  
  % Load the coefficients
  load(sprintf('synthcoef_L%d.mat',Lmax));

  % Load the data locations
  load('MercDataLocMarApr2013.mat')
  % order is: lon,lat,rad

  % Keep only below maxalt 
  indx = data(:,3)-2440 < maxalt;
  data = data(indx,:);

  % Keep only north of minlat
  indx = data(:,2) > minlat;
  data = data(indx,:);

  % Reduce altitude. In MercDataLoc, the order is lon, lat, rad
  data(:,3) = data(:,3) - reducealt;

  % calculate Br, Bth, Bph values
  synthData = rGvec(coef, (90-data(:,2))*pi/180, data(:,1)*pi/180, data(:,3), rplanet, 0);
  n = size(data,1);

  Br = synthData(1:n); Bth = synthData(n+1:2*n); Bph = synthData(2*n+1:end);

%%%% Order of synth data
%%%% r, th, phi, Br, Bth, Bp
  data = [data(:,3),(90-data(:,2))*pi/180,data(:,1)*pi/180,Br(:),Bth(:),Bph(:)];
  
  save(sprintf('synthdata_L%d_reducealt%g',Lmax,reducealt),'data');
