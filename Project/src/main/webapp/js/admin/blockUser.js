/**
 * 
 */
 
 $(function(){
	requestBlockUserList();
})
 
function requestBlockUserList(){
	
	console.log("requestBlockUserList");
	
	let parent = $("#items"); 
	parent.empty();
	
	for(let i=0;i<2;i++){
		addBlockUserObject(parent, "");
	}
	
	
}
 
function addBlockUserObject(parent, data){
	
	let html ='<div class="settingMain">';
		html+='  <img src="./자산 4.png" class="profile">';
		html+='  <span class="span">abcabcs123';
		html+='    <span class="span2">abc마트</span>';
		html+='  </span>';
		html+='  <button class="labelBtn " id="label">차단해제</button>';
		html+='</div>';
		
	parent.append(html);
}