addpath(genpath('../common'));

data = extractFeaturesSegments('XY_floret_dendrogram.xml');

mean_floret = mean(data(:,2));
std_floret = std(data(:,2));

maximal_depth = max(data(:,1));

U = unique(data(:,3));
depth = zeros(size(U));
var_data = zeros(size(U));
mean_data = zeros(size(U));
log2params = zeros(length(U),2);
max_depth = zeros(length(U),1);
size_data = zeros(length(U),1);
trivial_florets = 0;
largest_floret = 0;

tf = [];
ntf = [];

for i=1:length(U)
            
    act_floret = data(data(:,3) == U(i),2);            
    if length(act_floret) == 1
        trivial_florets = trivial_florets + 1;
        tf = [tf; act_floret];
    else 
        ntf = [ntf; act_floret(1)];
    end
    
    var_data(i) = std(act_floret);
    mean_data(i) = mean(act_floret);

    log2params(i,1) = mean(log(act_floret));
    log2params(i,2) = std(log(act_floret));

    act_floret = data(data(:,3) == U(i),1);            
    asym(i) = asymmetry(act_floret);
    
    asymweight(i) = asymmetry(data(data(:,3) == U(i),1:2));
    
    depth(i) = mean(act_floret);
    max_depth(i) = max(act_floret);

    size_data(i) = length(act_floret);       
end

mean_asym = mean(asym);
std_asym = std(asym);

mean_asym_w = mean(asymweight);
std_asym_w = std(asymweight);

log3fitresult = log3fit(data(:,2));
log3fitresultGA = zeros(1,3);
[log3fitresultGA(1) ,log3fitresultGA(2), log3fitresultGA(3)] = shifted_lognormal_param_estimation(data(:,2));

fprintf('Mean of segment lengths: %.2f \n', mean_floret);
fprintf('Standard deviation of segment lengths: %.2f \n', std_floret);
fprintf('Skewness of the distribution of segment lengths: %.2f \n', skewness(data(:,2)));
fprintf('Mean of asymmetry values: %.2f \n', mean_asym);
fprintf('Standard deviation of asymmetry values: %.2f \n', std_asym);

fprintf('Mean of weighted asymmetry values: %.2f \n', mean_asym_w);
fprintf('Standard deviation of weighted asymmetry values: %.2f \n', std_asym_w);


fprintf('Number of florets: %d \n', length(U));
fprintf('Average number of segments floretwise: %.2f \n', mean(size_data));
fprintf('Average depth of florets: %.2f \n', mean(max_depth));
fprintf('Number of trivial florets: %d \n', trivial_florets);
fprintf('Maximal depth: %d \n', maximal_depth);
fprintf('Mean of the fitted lognormal distribution: %.2f \n', mean(log(data(:,2))));
fprintf('Standard deviation of the fitted lognormal distribution: %.2f \n', std(log(data(:,2))));


fprintf('Mean of the fitted 3 parameter lognormal distribution: %.2f \n', log3fitresult(1));
fprintf('Standard deviation of the fitted 3 parameter lognormal distribution: %.2f \n', log3fitresult(2));
fprintf('Shift of the fitted 3 parameter lognormal distribution: %.2f \n', log3fitresult(3));

fprintf('Mean of the fitted 3 parameter lognormal distribution with GA: %.2f \n', log3fitresultGA(1));
fprintf('Standard deviation of the fitted 3 parameter lognormal distribution with GA: %.2f \n', log3fitresultGA(2));
fprintf('Shift of the fitted 3 parameter lognormal distribution with GA: %.2f \n', log3fitresultGA(3));

