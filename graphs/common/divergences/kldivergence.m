function klresult = kldivergence(data2,data1)

    infinum = min([data1; data2]);
    sup = max([data1; data2]);
        
    stepSize = (sup-infinum)/200;
    pdfGenerated = zeros(floor(sup)-ceil(infinum)+1,1);
    pdfTestData = zeros(floor(sup)-ceil(infinum)+1,1);
    
    j = 1;
    i = infinum;
    while i < sup + stepSize
        pdfGenerated(j) = sum(i + stepSize >= data1 & data1 > i - stepSize); 
        pdfTestData(j) = sum(i + stepSize >= data2 & data2 > i - stepSize); 
        j = j + 1;
        i = i + 2 * stepSize;
    end
   
    pdfGenerated = pdfGenerated./size(data1,1);
    pdfGenerated = (pdfGenerated + eps)./(sum(pdfGenerated) + length(pdfGenerated)*eps);
    
    pdfTestData = pdfTestData./size(data2,1);
    pdfTestDataTemp = (pdfTestData + eps)./(sum(pdfTestData) + length(pdfGenerated)*eps);
    pdfTestDataTempZeros = pdfTestDataTemp; pdfTestDataTempZeros(pdfTestData == 0) = 0;        
    
    klresult = (log(pdfTestDataTemp./pdfGenerated))'*pdfTestDataTempZeros;