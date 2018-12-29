function plot_tree_dendrogram(floretData, rootX, rootY, label)

    minX = rootX; maxX = rootX; 
    minY = rootY; maxY = rootY;
    root_segment = true;
    
    length_subf = floretData(2,2);
    
    plot_tree(floretData, rootX, rootY,'k');
    
    
    
    axis([minX - 5, maxX + 5, minY - 5, maxY + 5]);
    

    function plot_tree(floretData, rootX, rootY, color)
        offsetL = 2;
        offsetR = 2;
        exponent = 1.35;
        hold on;
        
        if strcmp(color,'k')
            label = '';
        end
        
        if (length_subf == floretData(1,2))
            color = 'r';
            label = 'segmenttype';
        end
        
        if size(floretData,1) > 0
            bl = rootX + floretData(1,2);
            
            if bl > maxX 
                maxX = bl;
            end
            
            if maxY < rootY  
                maxY = rootY;
            end
            
            
            if minY > rootY  
                minY = rootY;
            end                        

            plot([rootX, bl], [rootY, rootY],color,'LineWidth',3);
            
            %% for depth : floretData(1,1)
            %% for length : floretData(1,2)
            switch (label)
                case 'segmenttype'                    
                    if root_segment
                        root_segment = false;
                        text((rootX + bl)/2, rootY, sprintf('%s','R'),'FontSize', 20,'Color', color, 'BackgroundColor',[1 1 1]); 
                    elseif size(floretData,1) > 1 && bl-rootX < 12                
                        text(rootX, rootY + 2, sprintf('%s','I'),'FontSize', 20,'Color', color,'BackgroundColor',[1 1 1]);
                    elseif size(floretData,1) == 1
                        text((rootX + bl)/2, rootY, sprintf('%s','T'),'FontSize', 20,'Color', color,'BackgroundColor',[1 1 1]);
                    else
                        text((rootX + bl)/2, rootY, sprintf('%s','I'),'FontSize', 20,'Color', color, 'BackgroundColor',[1 1 1]);
                    end
                case 'depth'
                    if size(floretData,1) > 1 && bl-rootX < 12                
                        text(rootX, rootY + 2, sprintf('%d',floretData(1,1)),'FontSize', 20,'Color', color,'BackgroundColor',[1 1 1]);
                    else 
                        text((rootX + bl)/2, rootY, sprintf('%d',floretData(1,1)),'FontSize', 20,'Color', color,'BackgroundColor',[1 1 1]);
                    end
                case 'lengths'
                    if size(floretData,1) > 1 && bl-rootX < 12                
                        text(rootX, rootY + 2, sprintf('%d',floretData(1,1)),'FontSize', 20,'Color', color,'BackgroundColor',[1 1 1]);
                    else 
                        text((rootX + bl)/2, rootY, sprintf('%d',floretData(1,1)),'FontSize', 20,'Color', color,'BackgroundColor',[1 1 1]);
                    end
            end

            floretIndex = [];
            if size(floretData,1) > 1 && floretData(2,1) > floretData(1,1) 
                floretIndex = find(floretData(2:end,1) == floretData(2,1)) + 1;
            end

            if length(floretIndex) == 1
                plot_tree(extractSubFloret2(floretData,floretIndex(1)),bl, rootY, color);
            elseif length(floretIndex) == 2     
                floretDataL = extractSubFloret2(floretData,floretIndex(1));
                floretDataR = extractSubFloret2(floretData,floretIndex(2));

                vectorToPlotY = [rootY, rootY + (offsetR + size(floretDataL,1))^exponent];
                vectorToPlotX = [bl, bl];
                plot(vectorToPlotX,vectorToPlotY,color,'LineWidth',3);

                vectorToPlotY = [rootY - (size(floretDataR,1) + offsetL)^exponent, rootY];
                vectorToPlotX = [bl,bl];
                plot(vectorToPlotX,vectorToPlotY,color,'LineWidth',3);

                plot_tree(floretDataL,bl, rootY + (size(floretDataL,1)  + offsetR )^exponent, color);
                plot_tree(floretDataR,bl, rootY - (size(floretDataR,1)  + offsetL )^exponent, color);
            end
        end
    end
end