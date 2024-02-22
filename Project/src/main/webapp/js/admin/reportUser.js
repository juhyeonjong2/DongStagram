/**
 * 
 */
 
 $(function(){
	requestReportUserList();
})
 
 function requestReportUserList(){
	
	let parent = $("#items"); 
	parent.empty();
	
	for(let i=0;i<20;i++){
		addReportUserObject(parent, "");
	}
}
 
 
function addReportUserObject(parent, data){
	
 let html = '<div class="settingMain">';
     html+= '	<img src="./자산 4.png" class="profile">';
	 html+= '	<span class="span">abcabcs123';
	 html+= '	<span class="span2">abc마트</span>';
	 html+= '		<span class="span3">신고횟수·11회</span>';
	 html+= '	</span>';
	 html+= '	<button class="blockBtn " id="label">차단</button>';
     html+= '</div>';
	
	parent.append(html);
	
}
 
