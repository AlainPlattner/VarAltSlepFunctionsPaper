function testMM(offrad)

  show=true;
  save=true;
  
  N=10000;
  Lmax = 60;
  dom = 'africa';
  rplanet = 6371;
  J = round(1.5*spharea(dom,0)*(Lmax+1)^2);

  rsatfun = @ellipsisEarthS;
  rsatfunsav = 'ellipsisEarthS';

  [G,V] = glmalphaupLatvar(dom,Lmax,rplanet,rsatfun,rsatfunsav,1);
  

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
    savenameMM=fullfile('gmt','data','MM',sprintf('MM_offrad%g.grd',offrad));
    savenameMMdiag=fullfile('gmt','data','MM',sprintf('MM-diag_offrad%g.txt',offrad));
    savenameV=fullfile('gmt','data','MM',sprintf('V.txt'));

    savenameVm=fullfile('gmt','data','MM',sprintf('Vm_offrad%g.txt',offrad));
    
    grdwrite2p(1:J,1:J,MM,savenameMM);
    writematrix([(1:J)',diag(MM)], savenameMMdiag, 'Delimiter', '\t');
    writematrix([(1:J)',V(1:J)'], savenameV, 'Delimiter', '\t');

    % also calc and save Eigs
    Vm = eig(MM);
    Vm = sort(Vm,'descend');
    try
      writematrix([(1:length(Vm))',Vm],savenameVm, 'Delimiter', '\t')
    catch
      keyboard
    end
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

