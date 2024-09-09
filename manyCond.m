function manyCond()

  J=600;

  typ = {'classical','fix','var'};

  for i=1:length(typ)
      MercCond(typ{i},J);  
  end
