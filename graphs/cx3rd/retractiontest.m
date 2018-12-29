load outM3.csv;

%outM3 = outM2;

U = unique(outM3(:,3));

gen_data = [];

j = 0;

for i=1:length(U)
    data = outM3(outM3(:,3) == U(i),1:2);
    transformed = transformData(data);
    
    if ~isempty(transformed)
        j = j + 1
        transformed = [transformed ones(size(transformed,1),1) * j];
        gen_data = [gen_data; transformed];
    end
    
end

csvwrite('outx.csv',gen_data)