/**
 * 
 */
 
 $(function(){
	requestReportUserList();
})
 
 function requestReportUserList(){
	
	
	$.ajax(
	{
		url: "/Dongstagram/data/report/userlist",
		type: "post",
		success: function(resData) {
			let obj =JSON.parse(resData.trim());
			
			if(obj.result =="SUCCESS")
			{
				let parent = $("#items"); 
				parent.empty();
				
				for(let i=0;i<obj.list.length; i++)
				{
					addReportUserObject(parent, obj.list[i]);
				}
			}
		},
		error: function() {
			//consloe.log("FAIL");
			
		}
	});
	
}
 
 
function addReportUserObject(parent, data){
	

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
	 html+= '	<span class="span2">'+data.name+'</span>';
	 html+= '		<span class="span3">신고횟수·'+data.count +'회</span>';
	 html+= '	</span>';
	 html+= '	<button class="blockBtn " id="label" onclick="requestBlockUser(this)">차단</button>';
     html+= '</div>';
	
	parent.append(html);
	
}

function requestBlockUser(o){

	let me = $(o);
	let parent = me.closest(".settingMain");
	let mno = parent.find("input.mno").val();

	//차단
	$.ajax({
		url:"/Dongstagram/data/block/user", 
		type:"post",
		data : {mno : mno},
		success:function(resData){	
			if(resData.trim() == "SUCCESS")
			{
				requestReportUserList();
			}
		 } // success
	 });
}

