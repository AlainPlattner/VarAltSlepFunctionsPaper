function int = testOrtho(i,j)


  dth = 0.01;
  dph = 0.01;
  theta = dth:dth:pi-dth;
  phi = 0:dph:2*pi;
  [TH,PH] = meshgrid(theta,phi); 
  
  Lmax = 2;
  
  E = elm(Lmax,theta,phi);

  Eir = E{1}(i,:);
  Eir = reshape(Eir,length(theta), length(phi));
  Ejr = E{1}(j,:);
  Ejr = reshape(Ejr,length(theta), length(phi));

  Eit = E{2}(i,:);
  Eit = reshape(Eit,length(theta), length(phi));
  Ejt = E{2}(j,:);
  Ejt = reshape(Ejt,length(theta), length(phi));

  Eip = E{3}(i,:);
  Eip = reshape(Eip,length(theta), length(phi));
  Ejp = E{3}(j,:);
  Ejp = reshape(Ejp,length(theta), length(phi));

  %keyboard
  Ir = sum(sum(Eir.*Ejr.*sin(TH'))*dth*dph);
  It = sum(sum(Eit.*Ejt.*sin(TH'))*dth*dph);
  Ip = sum(sum(Eip.*Ejp.*sin(TH'))*dth*dph);

  int = Ir + It + Ip;




  
