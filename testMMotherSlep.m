function testMMotherSlep(wchSlp, offrad)
  % wchSlp either 'classical' or 'fix'

  
  show=true;
  save=true;
  
  N=10000;
  Lmax = 60;
  dom = 'africa';
  rplanet = 6371;
  J = round(1.5*spharea(dom,0)*(Lmax+1)^2);

  %rsatfun = @ellipsisEarthS;
  %rsatfunsav = 'ellipsisEarthS';

  switch wchSlp
    case 'classical'
      [G,V] = glmalpha(dom,Lmax);
      V=V';
    case 'fix'
      rsat = rplanet+607;
      [G,V] = glmalphaup(dom,Lmax,rsat,rplanet);
    otherwise
      error("please choose 'classical' or 'fix' ")
  end
  

  % Make random data
  % Lon, lat within Africa
  [lon,lat]=randinpoly(dom,N);

  % r on ellipsisEarthS
  rad = max(ellipsisEarthS(cos((90-lat)*pi/180)) + randn(size(lat))*offrad,rplanet);


 
  % evaluate G at those points
  M=rGscal(G(:,1:J),pi/180*(90-lat),pi/180*lon,rad,rplanet,1);

  MM = M*M'/length(lat); % Dividing by the number of points to simulate integral
  clear M;

  if save
    savenameMM=fullfile('gmt','data','MM',sprintf('MM_%s_offrad%g.grd',wchSlp,offrad));
    savenameMMdiag=fullfile('gmt','data','MM',sprintf('MM_%s-diag_offrad%g.txt',wchSlp,offrad));
    savenameV=fullfile('gmt','data','MM',sprintf('V_%s.txt',wchSlp));
    savenameVm=fullfile('gmt','data','MM',sprintf('Vm_%s_offrad%g.txt',wchSlp,offrad));
    
    grdwrite2p(1:J,1:J,MM,savenameMM);
    writematrix([(1:J)',diag(MM)], savenameMMdiag, 'Delimiter', '\t');
    writematrix([(1:J)',V(1:J)'], savenameV, 'Delimiter', '\t');

    % also calc and save Eigs
    Vm = eig(MM);
    Vm = sort(Vm,'descend');
    writematrix([(1:length(Vm))',Vm],savenameVm, 'Delimiter', '\t')
  end
  
  if show
    figure(1)
    imagesc(MM);
    kelicol(1)
    caxis([-1,1]*max(abs(MM(:))))
    colorbar

    la = diag(MM);

   % keyboard
    figure(2)
    semilogy(la);
    hold on
    semilogy(V(1:J));
    semilogy(Vm(1:J),'--');
    hold off
  end
  
  %keyboard

