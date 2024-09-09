function dat = readDataFile(filename,subsample,maxalt)
  % Written for MAG MBF SCI AVG
  % doi: 10.17189/1519746

  rplanet = 2440;
  
  data = load(filename);
  
  data = data(1:subsample:end,:);
  
  % Data order:
  % year, day, hour, min, sec, timetag, navg, X, Y, Z, BX, BY, BZ, DBX, DBY, DBZ
  % day is day of year
  % navg is number of samples in averaging time interval
  % X, Y, Z (location) are in km from Mercury's center. Columns 8,9,10
  % BX, BY, BZ (mag components) are in nT. Columns 11,12,13
  % DBX, DBY, DBZ (std of mag data) are in nT
  
  X = data(:,8);
  Y = data(:,9);
  Z = data(:,10);

  [phi, elev, r] = cart2sph(X,Y,Z);
  phi = mod(phi,2*pi);
  indx = (r <= maxalt + rplanet);
  dat = [phi*180/pi,elev*180/pi,r];
  dat = dat(indx,:);
