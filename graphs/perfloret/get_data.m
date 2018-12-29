     %% GET STATISTICS
    function ret_data = get_data(data)
        ulosl=900; %upper limit on segment length
        llosl=1;   %lower limit on segment length
        data=data(logical((data(:,2)<=ulosl).*(data(:,2)>=llosl)),:); %Segments with unwanted lengths are deleted.
        
        U = unique(data(:,3));

        var_data = zeros(size(U));
        mean_data = zeros(size(U));
        log2params = zeros(length(U),2);        
        size_data = zeros(length(U),1);
        asym = zeros(length(U),1);
        depth = zeros(length(U),1);
        max_depth = zeros(length(U),1);

        for i=1:length(U)

            act_floret = data(data(:,3) == U(i),2);            
            var_data(i) = std(act_floret);
            mean_data(i) = mean(act_floret);
            
            log2params(i,1) = mean(log(act_floret));
            log2params(i,2) = std(log(act_floret));
            
            act_floret = data(data(:,3) == U(i),1);            
            asym(i) = asymmetry(act_floret);
            depth(i) = mean(act_floret);
            max_depth(i) = max(act_floret);

            size_data(i) = length(act_floret);
        end

        ret_data = [var_data, mean_data, log2params, size_data, asym, depth, max_depth, U]; %Floret ID's are placed in 9th column

    end
