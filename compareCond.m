function compareCond()

%function compareEigs(J,calc)

  J=600;
  
  typ = {'classical','fix','var'};

  % if calc
  %   for i=1:length(typ)
  %     MercEigs(typ{i},J);  
  %   end
  % end

  for i=1:length(typ)
    %name = sprintf('gmt/data/MercInvEig/Vinv_%s_J%i.txt',typ{i},J);
    name = sprintf('gmt/data/MercInvCond/Cond_%s_J%i.txt',typ{i},J);
    V=load(name); 
    semilogy(V(:,1),V(:,2));
    %plot(V(:,1),V(:,2))
    hold on
  end
  hold off

  xlabel('Number of Slepian functions J')
  ylabel('Condition number')
  legend(typ)
  %ylim([1,5e4])
    
    
