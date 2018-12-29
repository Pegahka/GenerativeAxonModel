function data = generateFloret(gp)

    % function generateFloret
    
    % input: gp stucture
    
    % example structure used for floret generation
    
    % gp.gen_distr = '@(p1,p2) gamrnd(p1,p2)';
    % gp.pl_growth = 2;
    % gp.pl_retract = 3;
    % gp.growth_p1 = 4;
    % gp.growth_p2 = 4;
    % gp.retract_p1 = 4;
    % gp.retract_p2 = 4;
    % gp.resource = 20;
    % gp.bias = 0.7;
    % gp.g_factor = 0.4;
    % gp.r_factor = 0.4;
    % gp.version = 2;
    
    % output nx2 matrix
    % column 1: branchlengths
    % column 2: depths

    measurement_treshold = 1.0;
    data = []; 
    
    
    gen_distr = eval(gp.gen_distr); % the distribution used for growth and retraction, usually gamma
    
    switch gp.version % different generator versions
        case 1 % without resource release, without primitive length in case of retraction, substracting 1 from resource at each step
            options.resource_release = 0; 
            options.pl_for_retract = 0;
            options.resource_fn = 1;            
        case 2 % without resource release, with primitive length in case of retraction, substracting 1 from resource at each step
            options.resource_release = 0;
            options.pl_for_retract = 1;
            options.resource_fn = 1;            
        case 3 % with resource release, with primitive length in case of retraction, substracting 1 from resource at each step
            options.resource_release = 1;
            options.pl_for_retract = 1;
            options.resource_fn = 1;            
        case 4 % with resource release, with primitive length in case of retraction, using sigmoid function for resource update
            options.resource_release = 1;
            options.pl_for_retract = 1;
            options.resource_fn = 2;            
        
    end
    
    grow_axon(gp.resource,1); % calling floret generation function with initial resource parameter and depth: 1.
    
    
    function ret = resource_release(length, version) % 
        switch version
            case 1
                ret = 1; % substracting 1
            case 2 
                ret = 1/(1+exp(-length)); % substracting the value of the sigmoid function
        end
    end
    
    function grow_axon(r,depth) % floret generator function
        growth = gp.pl_growth + gen_distr(gp.growth_p1,gp.growth_p2); % growth 
        
        if isfield(gp,'offset')
            data = [data; [depth, gp.offset + growth]];
        else
            data = [data; [depth, growth]];
        end      
        
        r = r - resource_release(growth,options.resource_fn); % decreasing resource        
        
        while r >= 1
            if (random('Uniform', 0.0, 1.0) < gp.g_factor) % growth with probability: g_factor  
                growth = gp.pl_growth + gen_distr(gp.growth_p1,gp.growth_p2);
                r = r - resource_release(growth,options.resource_fn);
                data(end,2) = data(end,2) + growth;
            elseif (random('Uniform', 0.0, 1.0) < gp.r_factor) % retraction with probability: (1 - g_factor) * r_factor
                
                if isfield(gp,'retract_p1') % if there is a field defined for retraction parameters we use those 
                                            % otherwise we use the same parameters as for growth
                    retract_p1 = gp.retract_p1;
                    retract_p2 = gp.retract_p2;
                else
                    retract_p1 = gp.growth_p1;
                    retract_p2 = gp.growth_p2;
                end
                
                if (options.pl_for_retract) % checking if we use primitive length for retraction.
                    if isfield(gp, 'pl_retract')
                        pl_retract = gp.pl_retract;
                    else
                        pl_retract = gp.pl_growth;
                    end                            
                else 
                    pl_retract = 0;
                end

                retraction = pl_retract + gen_distr(retract_p1,retract_p2); %retractions
                          
                if (options.resource_release)
                    r = r + resource_release(retraction,options.resource_fn);
                end
                
                % checking if rertraction is possible. If the retracted
                % branch's length is below measurement_treshold then full retraction
                % occures, growth is halted, resource allocated to that
                % part of the floret IS LOST
                
                if (data(end,2) - retraction > measurement_treshold)
                    data(end,2) = data(end,2) - retraction;
                else                                        
                    data(end,2) = -1;                    
                    break;
                end
                
            else % neither growth and retraction occure then bifurcation takes place with probability: (1-g_factor)(1-r_factor)
                
                
                % since in a floret left and right subflorets can be
                % reversed without effecting any relevant property, bias is
                % constrained to be in the interval [0.5 1].                                             
                
                % sampling bias 
                % initializing the resources allocated to left and right
                % subflorets at the minimum value at which they allow the
                % development of the respective subflorets.
                rl = 1; rr = 1;
                
                % sampling bias 
                bias = random('Uniform', gp.bias, 1.0);
                % bias = gp.bias;
              
                % bias is scaled with (r-2) since 2 resources were already
                % allocated.               
                rl = rl + bias * (r-2);
                rr = rr + (1-bias) * (r-2);
                
                % this way either:
                % 1. rl >= 1 and rr > 1, when r >= 2
                % 2. rl < 1 and rr < 1, when r < 2
       
                % resource allocation to the subflorets
                % new condition
                if (rl>=1 && rr>=1) 
                    grow_axon(rl, depth + 1);
                    grow_axon(rr, depth + 1);
                    break;
                else 
                    break;
                end

            end
        end
    end    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%% POST PROCESSING (FULL RETRACTION) %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %% CHECKING IF ROOT RETRACTD 
    if size(data,1) == 1 && data(1,2) == -1
        data = [];
        return;
    end
    
    %% IF ROOT DIDN'T RETRACT FLORET SIZE IS EITHER 1 OR > 2

    if (size(data,1) > 2)
        i = 1;                                      
        
        while i < size(data,1) + 1 %% ITERATING THROUGH THE FLORET
            if data(i,2) == -1 %% CHECKING FOR FULLY RETRACTED BRANCHES
                if data(i-1,1) == (data(i,1) - 1)                     
                    %                                |
                    %   LEFT SEGMENT RETRACTED  ->  / \ 
                    j = i + 1;
                    if data(j,2) == -1 %% EASY CASE: LEFT AND RIGHT SEGMENTS BOTH RETRACT
                        data(i:i+1,:) = [];
                    else                        
                        %% IDENTIFYING RIGHT SUBFLORET
                        first = 1; 
                        while j < size(data,1) && (data(i+1,1) < data(j,1) || first)
                            first = 0;
                            j = j + 1;
                        end
                        
                        if data(i + 1,1) >= data(j,1) 
                            j = j - 1;
                        end
                        
                        %% DECREASING DEPTH OF SEGMENTS FROM RIGHT SUBFLORET
                        % VANSISH RETRACTED SEGMENT AND ITS SIBLING
                        % ADDING LENGTH OF SIBLING TO THE PARENT. 
                        data(i-1,2) = data(i-1,2) + data(i+1,2);
                        data(i:j,1) = data(i:j,1) - 1;
                        data(i:i+1,:) = []; 
                    end
                else                    
                    %%       |
                    %       / \ <- RIGHT SEGMENT RETRACTED
                    j = i - 1;
                    if data(j,2) == -1
                        data(i-1:i,:) = [];
                    else                        
                        while data(j,1) ~= data(i,1)
                            j = j - 1;
                        end
                    end
                    
                    data(j-1,2) = data(j - 1,2) + data(j,2);
                    data(j:i,1) = data(j:i,1) - 1;
                    data(i,:) = []; data(j,:) = [];
                end
                
                i = i - 1;
            else            
                i = i + 1;
            end
        end        
    end

end