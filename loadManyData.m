function data = loadManyData(year,dayrng,sampling)

  maxalt = 1000;
  subsample = 1;
  
  fileprefix = sprintf('MAGMBFSCIAVG%d',year-2000);
  filepostfix = sprintf('_%02d_V08',sampling);

  data = [];
  
  for d = 1:length(dayrng)
    filename = [fileprefix,sprintf('%03d',dayrng(d)),filepostfix];
    datafile = fullfile('dataRaw', sprintf('%d',year), [filename,'.TAB']);

    dat = readDataFile(datafile,subsample,maxalt);
    data = [data;dat];
  end
