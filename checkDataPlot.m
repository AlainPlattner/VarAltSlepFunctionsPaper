function checkDataPlot(data)

  rplanet = 2440;

  figure(1)

  plot(data(:,2),data(:,3)-rplanet,'.')
  xlabel('latitude')
  ylabel('altitude')


  figure(2)
  scatter(data(:,1),data(:,2),1,data(:,3)-rplanet)
  colorbar

