function [ret, jsRaw] = shannonjensen(data1,data2)

    inf = min([data1; data2]);
    sup = max([data1; data2]);
        
    stepSize = (sup-inf)/200;
    pdfGenerated = zeros(floor(sup)-ceil(inf)+1,1);
    pdfTestData = zeros(floor(sup)-ceil(inf)+1,1);
    
    j = 1;
    i = inf;
    while i < sup + stepSize
        pdfGenerated(j) = sum(i + stepSize >= data1 & data1 > i - stepSize); 
        pdfTestData(j) = sum(i + stepSize >= data2 & data2 > i - stepSize); 
        j = j + 1;
        i = i + 2 * stepSize;
    end
   
    pdfGenerated = pdfGenerated./size(data1,1);
    pdfGenerated = (pdfGenerated + eps)./(sum(pdfGenerated) + length(pdfGenerated)*eps);
    
    pdfTestData = pdfTestData./size(data2,1);
    pdfTestData = (pdfTestData + eps)./(sum(pdfTestData) + length(pdfGenerated)*eps);
    
    jsRaw = (log(2*pdfTestData./(pdfGenerated+pdfTestData)).*pdfTestData + log(2*pdfGenerated./(pdfGenerated+pdfTestData)).*pdfGenerated)*0.5;
    
    ret = (log(2*pdfTestData./(pdfGenerated+pdfTestData))'*pdfTestData + log(2*pdfGenerated./(pdfGenerated+pdfTestData))'*pdfGenerated)*0.5;