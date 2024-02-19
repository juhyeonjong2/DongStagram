/**
 * 
 */
 
 // 참고 : https://this-programmer.tistory.com/136
 function numberToKorean(number){
    let inputNumber  = number < 0 ? false : number;
    let unitWords    = ['', '만', '억', '조', '경'];
    let splitUnit    = 10000;
    let splitCount   = unitWords.length;
    let resultValue  = 0.0;
    let wordIndex = 0;

    for (let i = 0; i < splitCount; i++){
         let unitResult = (inputNumber % Math.pow(splitUnit, i + 1)) / Math.pow(splitUnit, i);
         
         if(unitResult < 1.0){
			break;
		 }
		 
		 wordIndex = i;
         resultValue = unitResult.toFixed(1);
         if(resultValue% 1 === 0){
			resultValue = unitResult.toFixed(0);
		 }
    }
    
    return resultValue + unitWords[wordIndex];
}
