function [features nrFeatures] = processOneNode (node, depth)
% [features nrFeatures] = processOneNode (node, depth)
% 
% Extracts the features (length, depth) from the node of an axon, where the
% node is a brench
%
% features - extracted features
% nrFeatures - number of the extracted features
%

    nrFeatures = 1;
    features(nrFeatures, 2) = str2double(node.Attributes.length);
    features(nrFeatures, 1) = depth;
    
    if (isfield(node, 'branch'))
        
        if (length(node.branch) == 1)
            [ret nr] = processOneNode(node.branch, depth + 1);
            
            features = [features; ret];
            nrFeatures = nrFeatures + nr;
        else
            for i = 1:length(node.branch)
                [ret nr] = processOneNode(node.branch{i}, depth + 1);

                features = [features; ret];
                nrFeatures = nrFeatures + nr;
            end
        end             
    end
end