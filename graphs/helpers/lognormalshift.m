% addpath(genpath('../common'));
% 
% X = extractFeaturesSegments('XY_floret_dendrogram.xml');
% X = X(:,2);
% X(X < 1) = [];
% 
% 
% hist(log(X),50); title('Logarithm of real data');
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor',[0 122 0] / 255 ,'EdgeColor','w');
% xlabel('log(segment lengths)');
% ylabel('frequency');
% set(gcf, 'color', [1 1 1]);           
% 
% filename_rel_path = 'logdata.pdf';
% export_fig(filename_rel_path);

addpath(genpath('../common'));

X = extractFeaturesSegments('XY_floret_dendrogram.xml');
X = X(:,2);
X(X < 1) = [];


hist(log(X+2.9157),50); title('Logarithm of shifted real data');
h = findobj(gca,'Type','patch');
set(h,'FaceColor',[0 122 0] / 255 ,'EdgeColor','w');
xlabel('log(segment lengths)');
ylabel('frequency');
set(gcf, 'color', [1 1 1]);           

filename_rel_path = 'logdatashifted.pdf';
export_fig(filename_rel_path);
