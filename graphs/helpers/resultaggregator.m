directories = dir('../results');
addpath(genpath('../common'));

htmlFile = fopen([pwd '/report/report.html'], 'w');

fprintf(htmlFile,'<!DOCTYPE html> \n');
fprintf(htmlFile,'<html> \n');
fprintf(htmlFile,'<head> \n');
fprintf(htmlFile,'<link rel="stylesheet" type="text/css" href="table.css"> \n');
fprintf(htmlFile,'<script type="text/javascript" src="./jquery.js"></script> \n');
fprintf(htmlFile,'<script type="text/javascript" src="./jquery.tablesorter.js"></script> \n');
fprintf(htmlFile,'</head> \n');

fprintf(htmlFile,'<body> \n');

divergence = 1;

DIV{1} = 'Kullback-Leibler divergence';
DIV{2} = 'Reverse Kullback-Leibler divergence';
DIV{3} = 'Jensen-Shannon divergence';

x = extractFeaturesSegments('XY_floret_dendrogram.xml');


for divergence = 1:3
    
    header = 1;
    
    fprintf(htmlFile,sprintf('<h1> %s </h1>\n',DIV{divergence}));    
    fprintf(htmlFile,'<br> <br> \n');
    
    fprintf(htmlFile,'<table border="1" cellpadding="3" class="tablesorter"> \n');       

    for i=1:length(directories)

        if strcmp(directories(i).name,'.') || strcmp(directories(i).name, '..') || strcmp(directories(i).name(1),'.')
            continue;
        end
        
        
        
        if header == 1
            header = 0;
            fprintf(htmlFile,'<thead> \n');            
            addpath(genpath(['../results/' directories(i).name]));
            load('settings.mat');
            rmpath(genpath(['../results/' directories(i).name]));
            fprintf(htmlFile,'<tr> \n');
            for ii=1:settings.no_params
                fprintf(htmlFile,sprintf('<th> %s </th> \n', ...
                    settings.params{ii,3}));
            end
            
                fprintf(htmlFile,'<th> mean </th>');
                fprintf(htmlFile,'<th> std </th>');
                fprintf(htmlFile,'<th> divergence </th>');
            fprintf(htmlFile,'</tr> \n');  
            fprintf(htmlFile,'</thead> \n');
            fprintf(htmlFile,'<tbody> \n');
        end                

        directories(i).name
        addpath(genpath(['../results/' directories(i).name]));
        load('gaResult.mat');
        load('settings.mat');

        gaResultTmp = res{divergence,1};

        
        for j=1:length(gaResultTmp)

           fprintf(htmlFile,'<tr> \n');

           gp = struct;
           gaResult = gaResultTmp{j}; 
           for jj = 1:length(gaResult)
               fprintf(htmlFile,sprintf('<td> %2.2f </td> \n', gaResult(jj)));
               gp.(settings.params{jj,1}) = gaResult(jj);
           end
                      
           gp.no_florets = 50;
           
           if (gp.r_shape > 0 && gp.r_scale > 0)
               gp.res_distr = @(p1,p2) gamrnd(p1,p2);
           else
               gp.res_distr = @(p1,p2) identityFunction(p1,p2);
           end
           
           gp.gen_distr = @(p1,p2) gamrnd(p1,p2);
           gp.version = settings.generator_version;
           
           data = generateMultipleFlorets(gp);
           
           %% mean
           mu = mean(data(:,2));
           fprintf(htmlFile,sprintf('<td>%2.2f </td> \n', mu));
           %% std 
           
           stde = std(data(:,2));
           fprintf(htmlFile,sprintf('<td>%2.2f </td> \n', stde));
           %% divergence
           switch divergence
               case 1 
                   fprintf(htmlFile,sprintf('<td>%2.2f</td> \n', kldivergence(x(:,2),data(:,2))));
               case 2 
                   fprintf(htmlFile,sprintf('<td>%2.2f</td> \n', shannonjensen(x(:,2),data(:,2))));
               case 3 
                   fprintf(htmlFile,sprintf('<td>%2.2f</td> \n', kldivergence(data(:,2),x(:,2))));
           end
           
           fprintf(htmlFile,'</tr> \n');
        end            

        clear('res','settings')

        rmpath(genpath(['../results/' directories(i).name]));
    end       
    fprintf(htmlFile,'</tbody></table> \n');
end
fprintf(htmlFile,'<script type="text/javascript"> $(''table'').tablesorter();</script>;)');
fprintf(htmlFile,'</body> \n');
fprintf(htmlFile,'</html> \n');
fclose(htmlFile);