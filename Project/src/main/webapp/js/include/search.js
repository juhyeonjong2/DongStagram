/**
 * 
 */
 $(window).on("load", function() {
 	loadSearchHistory();
});

 
//디바운스 참고 :  https://velog.io/@klloo/JavaScript-%EC%93%B0%EB%A1%9C%ED%8B%80%EB%A7%81throttling%EA%B3%BC-%EB%94%94%EB%B0%94%EC%9A%B4%EC%8B%B1debouncing
var timer;
function searchContent(o){
	// 디바운스 적용
	
	// 200ms 동안 입력이 없으면 마지막 입력값으로 검색.
   if (timer) {
    clearTimeout(timer);
  }
  // 타이머 설정
  timer = setTimeout(function() {
    requestSearch($(o).val());
  }, 200);
 	
}

function requestSearch(value){
	console.log("requestSearch :" + value);
	if(value == null || value==""){
		loadSearchHistory();
	}
	else {
		// 아작스 통신
		$.ajax(
		{
			url: "/Dongstagram/data/search/content",
			type: "post",
			data: {searchWords : value},
			success: function(resData) {
				let obj =JSON.parse(resData.trim());	
				if(obj.result =="SUCCESS")
				{ 
					drawSearchContentSuccess(obj.contents);
				}
				else{
					drawSearchContentFail();
				}
			},
			error: function() {
				//consloe.log("FAIL");
				
			}
		});	
	}
}
function drawSearchContentFail(){
	$("#searchBody").empty();
	// 실패.
}

function drawSearchContentSuccess(contentList){
	console.log(contentList);
	
	$("#searchBody").empty();
	
	let html = '<hr>'; 
	    html+= '<div class="searchContainer" style="overflow-x:hidden; width:380px; height:750px;">';
		html+= '</div>';
	
	$("#searchBody").append(html);
	
	let parent = $("#searchBody .searchContainer");
	
	for(let i=0;i<contentList.length;i++){
		addContent(parent, contentList[i]);
	}
	
}

function addContent(parent, content){
	if(content.type == "nick"){
		addUserContent(parent, content);
	}
	else if(content.type == "tag") {
		addHashContent(parent, content);
	}
}

function addUserContent(parent, data){
	
	console.log("addUserContent");
	console.log(data);
	
	
	// DB에 검색 정보를 남기자. 쿠키가 더귀찮다. (searchHistory)
	let userNick = data.searchWords;
	let contextPath = "/Dongstagram";
	let mediaFolder = contextPath + "/upload/" + userNick + "/";
	let profileImagePath = contextPath +"/icon/profile.png";
	if(data.profileImage !=null){
		profileImagePath = mediaFolder + data.profileImage;
	}
	
	let profileLink = contextPath + "/user/" + userNick;
	
	let userName = data.name;
	let followers = data.followers;
	
	let html  = '<div class="search">';
		html += '	<a href="'+profileLink+'">';
		html += '		<img src="'+profileImagePath+'" class="profile">';
		html += '		<span class="span">'+ userNick +'</span>';
		html += '		<span class="span2">'+ userName +' · 팔로워 '+  numberToKorean(followers) +'명</span>';
		html += '	</a>';
		html += '</div>';
		
	parent.append(html);
}

function addHashContent(parent, data){
	
	
	// 미사용.
	console.log("addHashContent");
	console.log(data);
	
	let html =  '<div class="search">';
		html += '	<a href="./search.html">';
		html += '		<img src="/Dongstagram/icon/hashtag.png" class="profile">';
		html += '		<span class="span">검색 한 것</span>';
		html += '		<span class="span2">게시물 500만</span>';
		html += '	</a>';
		html += '</div>';
		
	parent.append(html);
}

function loadSearchHistory() {
	// 검색 기록을 로드함.
	// 최근 검색항목은 검색하고 엔터가 아니라 검색하고 클릭시에 해당 페이지를 로드할때 기록한다.
	$("#searchBody").empty();
	
	
	let html = '<hr>';
		html += '<div style="margin-bottom:20px">';
		html += '	<span style="margin-left:40px">최근 검색 항목</span>';
		html += '	<span onclick="alert(1111)" style="margin-left:100px">모두지우기</span>';
		html += '</div>';
		html += '<div class="searchContainer" style="overflow-x:hidden; width:380px; height:700px;">';
		html += '</div>';
	
	$("#searchBody").append(html);
	
	let parent = $("#searchBody .searchContainer");
	
	for(let i=0;i<2;i++){
		addUserContent(parent, "");
	}
	
	for(let i=0;i<2;i++){
		addHashContent(parent, "");
	}
	
	
	/*
	let html = '<hr>';
		html += '<div>';
		html += '	<span>최근 검색 항목</span>';
		html += '	<span onclick="alert(1111)">모두지우기</span>';
		html += '</div>';
		html += '<div class="searchContainer" style="overflow:auto;">';
		html += '	<div class="search">';
		html += '		<a href="./search.html">';
		html += '			<img src="./icon/hashtag.png" class="profile">';
		html += '			<span class="span">검색 한 것</span>';
		html += '			<span class="span2">게시물 500만</span>';
		html += '		</a>';
		html += '	</div>';
		html += '	<div class="search">';
		html += '		<a href="./search2.html">';
		html += '			<img src="./즐겁다 짤.jpg" class="profile">';
		html += '			<span class="span">abc마트</span>';
		html += '			<span class="span2">abc마트 · 팔로워 24.7만명</span>';
		html += '		</a>';
		html += '	</div>';
		html += '</div>';
		*/
		
	
}