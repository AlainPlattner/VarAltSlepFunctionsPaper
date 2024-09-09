function makeNoisyData(Lmax,pct)

  load(sprintf('synthdata_L%d_reducealt200.mat',Lmax));
  %load synthdata_L90.mat;

  Br_rms = rms(data(:,4));
  Bt_rms = rms(data(:,5));
  Bp_rms = rms(data(:,6));

  n = size(data,1);
  
  Br = data(:,4) + randn(n,1)*pct/100*Br_rms;
  Bt = data(:,5) + randn(n,1)*pct/100*Bt_rms;
  Bp = data(:,6) + randn(n,1)*pct/100*Bp_rms;

  data(:,4) = Br;
  data(:,5) = Bt;
  data(:,6) = Bp;

  save(sprintf('synthdata_L%d_reducealt200_noise%dpct',Lmax,pct),'data');

  

  
  
