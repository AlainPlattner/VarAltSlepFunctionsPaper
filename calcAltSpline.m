function p=calcAltSpline()

  % Calculates best fitting altitude for data

  load synthdata_L90_reducealt200.mat

  %I think

  %pp = spline(data(:,2),data(:,1));
  polyorder = 2;
  p = polyfit(cos(data(:,2)),data(:,1),polyorder);


  x = linspace(min(cos(data(:,2))), max(cos(data(:,2))), 100);
  
  %alt = ppval(pp,theta);
  
  alt = polyval(p,x);


  plot(90-180/pi*data(:,2),data(:,1)-2440,'.','color',[1,1,1]*0.6)
  hold on
  plot(90-180/pi*acos(x),alt-2440,'LineWidth',5,'color','k')
  hold off
  xlabel('latitude')
  ylabel('altitude')
