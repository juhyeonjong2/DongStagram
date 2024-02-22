/**
 * 
 */

let _swiper = [];
let _nowPage = 1;
let _isScrollEventLock = false;
$(window).on("load", function() {
 	// 미사용- 처음에 데이터를 보내주지 않을경우 여기서 요청해서 받아도 됨.
});

$(window).scroll(function(){
	let scrT = $(window).scrollTop();
	if(!_isScrollEventLock){
		
		if(scrT == $(document).height()-$(window).height()){
			// 스크롤이 끝에 도달 했음.
			//console.log("스크롤이 끝에 도달");
			requestNextPages(_nowPage);
		}else {
			//console.log("스크롤이 끝 아님");
		}
	}
});

function setNowPage(nowPage){
	_nowPage = nowPage;
}

function getNowPage(){
	return _nowPage;
}

function requestNextPages(nowPage){
	// 해당 함수 호출시 데이터가 모두 올때까지 스크롤 이벤트 처리 안함.
	_isScrollEventLock = true;
	$.ajax(
	{
		url: "/Dongstagram/data/home/views",
		type: "post",
		data: {nowPage : nowPage+1},
		success: function(resData) {
			let obj =JSON.parse(resData.trim());	
			if(obj.result =="SUCCESS")
			{
				loadPages(obj.views);
				
				if(obj.views.length > 0){
					setNowPage(nowPage +1);
				}
			}
			_isScrollEventLock = false;
		},
		error: function() {
			//consloe.log("FAIL");
			_isScrollEventLock = false;
		}
	});
}

function loadPages(views){
	//console.log(views);
	for(let i=0;i<views.length;i++)
	{
		addPage(views[i]);
	}
}


function addPage(view) {
	//console.log(view);
	
	let contextPath = "/Dongstagram";
	let mediaFolder = contextPath + "/upload/" + view.nick + "/";
	let profileImagePath = contextPath +"/icon/profile.png";
	if(view.profileImage !=null){
		profileImagePath = mediaFolder + view.profileImage;
	}
	let profileLink = contextPath + "/user/" + view.nick;
	let boardPageLink = contextPath + "/page/" + view.shorturi;
	
	
	let html = '<div class="page">';
		html += '	<div class="mainTop">';
		html += '		<img class="profile" src="' + profileImagePath + '" alt="ProfileImage" >';
		html += '		<a href="'+ profileLink +'" class="main1name">'+ view.nick +'</a>';
		html += '		<span class="span2 main1span writetime_'+ view.bno +'"></span>';
		html += '		<button type="button" onclick="follow(this)">팔로우</button>';
		html += '	</div>';
		html += '	<div class="slideShow">';
		html += '		<div class="swiper mySwiper_'+ view.bno +'">'; 
		html += '			<div class="swiper-wrapper">';
		for(let i=0;i<view.mediaList.length;i++)
		{
		html += '				<div class="swiper-slide">';
		html += '					<img src="'+ mediaFolder+view.mediaList[i].bfrealname +'" alt="'+ view.mediaList[i].bforeignname +'">';			
		html += '				</div>';
		}
		html += '			</div>';
		html += ' 			<div class="swiper-button-next"></div>';
		html += '			<div class="swiper-button-prev"></div>';
		html += '			<div class="swiper-pagination"></div>';
		html += '		</div>';
		html += '	</div>';
		html += '	<div>';  
		html += '		<div class="main2">';
		html += '			<form class="favoriteFrm" onsubmit="return false;">';
		html += '				<input type="hidden" name="bno" value="'+ view.bno +'">';
		html += '				<input type="hidden" name="req" value="1">';
		html += '				<img src="'+ contextPath+ '/icon/heart.png' +'" class="good favoriteImg_'+ view.bno +'" onclick="sendFavorite(this)">';
		html += '				<a href="'+ boardPageLink +'"><img src="'+ contextPath+ '/icon/reply.png' +'"></a>';
		html += '			</form>';
		html += '		</div>';
		html += '		<div class="main3">';
		html += '			<p> 좋아요 <span class="favorite_'+ view.bno +'"></span>개</p>';
		html += '		</div>';
		html += '		<div class="main4">';
		if(view.rootReply != null)
		{
		html += '			<a href="'+ profileLink +'">'+ view.nick +'</a>';
		html += '			<span class="rootReply_'+ view.bno +'"></span>';
		
		// 제거
		//html += '			<div class="tabmore">';
		//html += '				<div class="more"><a href="'+ boardPageLink +'">더보기</a></div>';
		//html += '			</div>';
		}
		html += '		</div>';
		html += '		<div class="main5">';
		if(view.replyList.length > 0)
		{
		html += '			댓글 <span class="reply_'+ view.bno +'"></span>개 <a href="'+ boardPageLink +'">모두보기</a>';
		}
		html += '		</div>';
		html += '		<form class="hotReply" onsubmit="return false;">';
		html += '			<input type="hidden" name="bno" value="'+ view.bno +'">';
		html += '			<input type="text" name="reply" placeholder="댓글 달기.." onkeyup="if(window.event.keyCode==13){sendHotReply(this);}">';
		html += '		</form>';
		html += '	</div>'; // e : 좋아요나 작성 글 등등
		html += '</div>';

	$("#maindiv").append(html);

	initSwiper("mySwiper_" + view.bno);
	setWriteDate("writetime_" + view.bno, view.wdate);
	setFavoriteCount("favorite_" + view.bno, view.bfavorite);
	setFavorite("favoriteImg_" + view.bno, view.mfavorite);
	if(view.rootReply != null){
		setShortContent("rootReply_" + view.bno, view.rootReply.rcontent);
	}
	if(view.replyList.length > 0){
		setReply("reply_" + view.bno, view.replyList.length);
	}

}
function initSwiper(className) {
	_swiper.push(new Swiper("." + className,
		{
			spaceBetween: 30,
			centeredSlides: true,
			pagination:
			{
				el: ".swiper-pagination",
				clickable: true,
			},
			navigation:
			{
				nextEl: ".swiper-button-next",
				prevEl: ".swiper-button-prev",
			},
		}));
}

function setWriteDate(className, date) {

	$("." + className).text(timeForToday(date));
}

function setFavoriteCount(className, number) {

	$("." + className).text(numberToKorean(number));
}

function setShortContent(className, text) {

	$("." + className).html(text);
}

function setReply(className, number) {
	$("." + className).text(numberToKorean(number));
}

function setFavorite(className, toggle) {
	if(toggle == 'y'){
		$("." + className).attr("src", "/Dongstagram/icon/clickheart.png");
	}
	else {
		$("." + className).attr("src", "/Dongstagram/icon/heart.png");
	}
}

function sendHotReply(o) {
	let inputReply = $(o);
	let frm = inputReply.closest(".hotReply");

	let params = frm.serialize();
	$.ajax(
		{
			url: "/Dongstagram/data/reply/hot",
			type: "post",
			data: params,
			success: function(resData) {
				let obj =JSON.parse(resData.trim());	
				if(obj.result =="SUCCESS")
				{
					//alert("댓글 등록에 성공");
					setReply("reply_"+obj.bno , obj.replyCount);
				}
				else {
					alert("댓글 등록에 실패");
				}
				inputReply.val('');
			},
			error: function() {
				//consloe.log("FAIL");
				inputReply.val('');
			}
		});
}

function sendFavorite(o){
	
	let inputReply = $(o);
	let frm = inputReply.closest(".favoriteFrm");
	
	let params = frm.serialize();
	$.ajax(
		{
			url: "/Dongstagram/data/favorite/toggle",
			type: "post",
			data: params,
			success: function(resData) {
				console.log(resData);
				let obj =JSON.parse(resData.trim());	
				if(obj.result =="SUCCESS")
				{
					setFavorite("favoriteImg_"+obj.bno , obj.isFavorite);
				}
				else {
					//alert("댓글 등록에 실패");
				}
			},
			error: function() {
				//consloe.log("FAIL");
			}
		});
}
