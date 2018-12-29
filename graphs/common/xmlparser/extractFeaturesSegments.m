function [data nrFeatures] = extractFeaturesSegments(filename)
% function [features nrFeatures] = extractFeatures(filename)
% 
% Extracts the features (length, depth) from the XML filme
%
% features - extracted features
% nrFeatures - number of the extracted features 
%   
    features = [];     % depth + length
    nrFeatures = 0;             % number of the branches
    xDoc = xmlread(filename);
    xmldata = xml2struct (xDoc);
    for i = 1:length(xmldata.root.cell.axon)
        [ret nr] = processOneNode(xmldata.root.cell.axon{i}.branch, 1);
                      
        ret = [ret ones(nr, 1) * str2num(xmldata.root.cell.axon{i}.Attributes.id)];
        
        features = [features; ret];
        nrFeatures = nrFeatures + nr;
    end
    
    U = unique(features(:,3));
    data = [];
    for i=1:length(U)
         x = sumSegments(features(features(:,3) == U(i),1:2));
         data = [data; [x ones(size(x,1),1)*U(i)]];
    end
end  