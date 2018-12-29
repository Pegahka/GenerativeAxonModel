function subfloret = extractSubFloret2(floretData, startingBranch)
%
% function subfloret = extractSubFloret(data, floretID, startingBranch)
% extract a subfloret
% Input:
% floretData = 3 by n matrix containing length, depth and Id parameters of
% branche
% startingBranch = the root of the subfloret
%
floretSize = size(floretData,1);

if (startingBranch > floretSize) 
    error('The subfloret does not exits... ');
end

subfloretSize = 1;

if (startingBranch == size(floretData,1))
    subfloret = floretData(startingBranch,:);
    return;
end

while ((subfloretSize + startingBranch -1 < floretSize) && (floretData(startingBranch,1) < floretData(startingBranch + subfloretSize,1)))
    subfloretSize = subfloretSize + 1;
end

subfloret = floretData(startingBranch:startingBranch + subfloretSize - 1,:);







