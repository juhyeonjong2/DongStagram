/**
 * 
 */
 
 $(function(){
	requestBlockUserList();
})
 
function requestBlockUserList(){
	
	
	$.ajax(
	{
		url: "/Dongstagram/data/block/userlist",
		type: "post",
		success: function(resData) {
			let obj =JSON.parse(resData.trim());
			
			if(obj.result =="SUCCESS")
			{
				let parent = $("#items"); 
				parent.empty();
				
				for(let i=0;i<obj.list.length; i++)
				{
					addBlockUserObject(parent, obj.list[i]);
				}
			}
		},
		error: function() {
			//consloe.log("FAIL");
			
		}
	});
	
}
 
function addBlockUserObject(parent, data){
	
	let userNick = data.nick;
	let contextPath = "/Dongstagram";
	let mediaFolder = contextPath + "/upload/" + userNick + "/";
	let profileImagePath = contextPath +"/icon/profile.png";
	if(data.profileImage !=null)
	{
		profileImagePath = mediaFolder + data.profileImage;
	}
	let profileLink = contextPath + "/user/" + userNick;
	
	
	let html = '<div class="settingMain">';
		html+= '   <input type="hidden" class="mno" value="'+ data.mno + '">';
		html+= '	<img src="'+profileImagePath+'" class="profile">';
	 	html+= '	<span class="span"><a href="'+profileLink +'">'+ userNick + '</a>';
	 	html+= '		<span class="span2">'+data.name+'</span>';
		html+= '  	</span>';
		html+= '  <button class="labelBtn " id="label" onclick="requestUnBlockUser(this)">차단해제</button>';
		html+= '</div>';
		
	parent.append(html);
}

function requestUnBlockUser(o){

	let me = $(o);
	let parent = me.closest(".settingMain");
	let mno = parent.find("input.mno").val();

	//차단
	$.ajax({
		url:"/Dongstagram/data/unblock/user", 
		type:"post",
		data : {mno : mno},
		success:function(resData){	
			if(resData.trim() == "SUCCESS")
			{
				requestBlockUserList();
			}
		 } // success
	 });
}