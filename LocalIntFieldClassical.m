function coef = LocalIntFieldClassical(data,rad,cola,lon,dom,Lmax,J,rplanet)
% Don't use this function in an actual application. This is just to show how poorly it works
%
% INPUT:
%
% Required:
%
% data      EITHER radial component data:
%              column vector of values for the points given as rad,cola,lon
%           OR vectorial data:
%              givpien as data{1}=rad component, data{2}=colat component,
%              data{3}=lon component, 
%              or data is a vector of length 3*length(rad) as [rad;cola;lon]
% rad       radial position of satellite (planet radius + altitude)
% cola,lon  colatitude/longitude positions of the data values (both as
%           column values), 0<=cola<=pi; 0<=lon<=2pi
% dom       Slepian concentration target region either given as string 
%           (one of the region names)
%           OR integer (polar cap opening angle in degrees)
%           OR two polar cap opening angles for the ring in between them
%           OR [lon lat] an ordered list defining a closed curve [degrees]
%           OR several regions to add up/subtract (ONLY FOR VECTORIAL DATA): 
%           struct with
%           dom.name    for name of the combined region
%           dom.parts   for the cell array of names of the parts, 
%                       or cap opening angles
%                       or [cap,lon,colat] for rotated caps
%           dom.sign    for adding or subtracting 
%           Example: dom.parts{1}='namerica'; dom.parts{2}='samerica';
%                    dom.sign=[1,1]; dom.name='americas';
%                    dom.name='weirdRing'
%                    dom.parts{1}=30; dom.parts{2}=[5,5,10]; dom.sign=[1,-1]
%                    subtracts the ring of cTH=5, clon=5, ccola=10 from the
%                    larger polar cap
% Lmax      Maximum spherical harmonic degree
% J         How many Slepian functions should be used to calculate the
%           solution? More means more sensitive to noise but higher spatial
%           resolution
% rplanet   Planet radius to which the solution should be calculated
%
%
% OUTPUT:
%
% coef          spherical-harmonic coefficients of the potential field
%               in ADDMON format
%
% Last modified by plattner-at-alumni.ethz.ch, 3/31/2023  


  niter = 10;
  
  if length(data)==3
    data=[data{1};data{2};data{3}];
  end
  
  if ischar(dom) 
    [G,V] = glmalpha(dom,Lmax);
  elseif length(dom)==2
    [G,V] = glmalpharing(dom,Lmax);
  end

  %% Radial position only
  if length(data)==length(rad)
    M=rGscal(G(:,1:J),cola,lon,rad,rplanet,1);

  %% All three vector components
  elseif length(data)==3*length(rad)
    M=rGvec(G(:,1:J),cola,lon,rad,rplanet,1);
    
  else
    error('number of locations does not match number of data values')
  end

  %% Solve for coefficients
  
  % first a least squares step
  MM=M*M';
  Md=M*data;
  slepcoef=MM\Md;
  % Now iteratively reweighted residuals
  [slepcoef,~,~]=itweighres(M,data,slepcoef,niter);
  coef=G(:,1:J)*slepcoef;

  coef=out2on(coef,max(Lmax));
