function msqe = calcmse(coefInv,coef,K,Lmax)

  defval('K',[])
  
  if 0
    dom = [29,6];

    % I may just do the idiot's version here and calculate the kernel for
    % a general region, because no one ever implemented the full kernel
    % for polar caps. Only the Slepians by solving smaller parts...
    % Or I could
    [G,V] = glmalpharing(dom,Lmax);
    % G is in ADDMOUT
    G = out2on(G,Lmax);

    K = (V.*G)*G';
    %Ktest = (G*diag(V))*G';
    save(sprintf('localKernel_L%d.mat',Lmax),'K')
  end

  if ~K
    load(sprintf('localKernel_L%d.mat',Lmax));
  end
    
  coefdiff = coef-coefInv;
  msqe = (coefdiff'*K)*coefdiff;
