/**
 * 
 */
 
 // 페이지가 로드되면 알림을 확인한다.
 
 $(function(){
	requestNotificationList();
})
 
 function requestNotificationList(){
	
	// 아작스 통신
	$.ajax(
	{
		url: "/Dongstagram/data/notification/list",
		type: "post",
		success: function(resData) {
			let obj =JSON.parse(resData.trim());
			
			if(obj.result =="SUCCESS")
			{
				let parent = $("#notificationBody");
				parent.empty();
				
				for(let i=0;i<obj.notificationList.length; i++)
				{
					addNotificationObject(parent, obj.notificationList[i]);
				}
			}
		},
		error: function() {
			//consloe.log("FAIL");
			
		}
	});
}
 
 function makeMsg(obj)
 {
	
	let msg = '정의되지 않은 알림 입니다.';
	if(obj.type == "FW")
	{
		
		if(obj.state == "REQ")
		{
			// 요청을 보냈다. (승인 해야한다.)
			msg = obj.nick+ '님이 회원님께 팔로우를 요청했습니다.';
		}
		else if(obj.state == "ACK")
		{
			// 팔로우 요청이 승인되었음. 즉, 나도 팔로우 할지 말지 보여줘야함.
			msg =  obj.nick+'님이 회원님을 팔로우 하기 시작했습니다.'
		}
	}
	
	return msg;
}

function makeNotificationLinkHtml(obj)
{
	let html = '';
	 if(obj.type == "FW")
	 {
		if(obj.state == "REQ")
		{
	 		html = '     <a href="#" class="atag2" onclick="return verifyNotificationFollow(this, '+ "'" + obj.nick + "'" + ');">승인</a>';
	 	} 
	 	else if(obj.state == "ACK")
	 	{
			if(obj.followState){
				 html = '     <a href="#" class="atag3" onclick="return requestNotificationFollow(this, '+ "'" + obj.nick + "'" + ');">언팔로우</a>';
			}
			else {
				html = '     <a href="#" class="atag2" onclick="return requestNotificationFollow(this, '+ "'" + obj.nick + "'" + ');">팔로우</a>';
			}
		}
	}
	return html;
}

function verifyNotificationFollow(o, nick){
	
	// 여기서 아작스 통신을 하고. 원래는 o를 고쳐야하는데 그냥 리로드 시키자. (시간이 없음)
	$.ajax(
	{
		url: "/Dongstagram/data/notification/verify",
		type: "post",
		data: {target:nick},
		success: function(resData) {
			let obj =JSON.parse(resData.trim());	
			if(obj.result =="SUCCESS")
			{
				requestNotificationList(); // 시간이 없으니 알림 재요청.
			}
		},
		error: function() {
			//consloe.log("FAIL");
			
		}
	});	
	
	return false; // href 동작 막기
}

function requestNotificationFollow(o, nick){
	
	$.ajax(
	{
		url: "/Dongstagram/data/follow/request",
		type: "post",
		data: {target:nick},
		success: function(resData) {
			let obj =JSON.parse(resData.trim());
			console.log(obj);	
			if(obj.result =="SUCCESS")
			{
				requestNotificationList(); // 시간이 없으니 알림 재요청.
			}
		},
		error: function() {
			//consloe.log("FAIL");
		}
	});
	
	return false; // href 동작 막기
}

 function addNotificationObject(parent, obj)
 {
	
	let userNick = obj.nick;
	let contextPath = "/Dongstagram";
	let mediaFolder = contextPath + "/upload/" + userNick + "/";
	let profileImagePath = contextPath +"/icon/profile.png";
	if(obj.profileImage !=null)
	{
		profileImagePath = mediaFolder + obj.profileImage;
	}
	let profileLink = contextPath + "/user/" + userNick;
	
 let html  = '<div class="notice">';
	 html += '	<div class="noticeContainer">';
	 html += '     <img src="'+profileImagePath+'" class="profile">';
	 html += '     <span class="span" onclick="moveProfilePage(' + "'"+profileLink+"'" + ')">'+makeMsg(obj);
	 html += '       <span class="span2">'+timeForToday(obj.rdate)+'</span>';
	 html += '     </span>';
	 html += makeNotificationLinkHtml(obj);
	 html += '	</div>';
	 html += '</div>';
	   
	parent.append(html);
	
}

function moveProfilePage(url){
	
	 location.href = url; 
}
