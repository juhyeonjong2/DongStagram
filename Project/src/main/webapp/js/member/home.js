/**
 * 
 */
 
 	let swiper =[]; 
	$(window).on("load", function() {
		init();
	});
	
	function init(){
		addPage("");
		addPage("");
		addPage("");
		addPage("");
		addPage("");
		addPage("");
		addPage("");
		addPage("");
		addPage("");
	}
	
	function addPage(jsonData){
		let html ='<div class="page">'
			+ '	<div class="mainTop">'
			+ '		<img src="./자산 4.png" class="profile">'
			+ '		<a href="#" class="main1name">닉네임</a>'
			+ '		<span class="span2 main1span">2일전</span>'
			+ '		<button type="button">팔로우</button>'
			+ '	</div>'
			+ '	<div class="slideShow">'
			+ '		<div class="swiper mySwiper">'
			+ '			<div class="swiper-wrapper">'
			+ '				<div class="swiper-slide"><img src="./즐겁다 짤.jpg"></div>'
			+ '				<div class="swiper-slide"><img src="./즐겁다 짤.jpg"></div>'		  
			+ '				<div class="swiper-slide"><img src="./즐겁다 짤.jpg"></div>'
			+ '			</div>'
			+ ' 		<div class="swiper-button-next"></div>'
			+ '			<div class="swiper-button-prev"></div>'
			+ '			<div class="swiper-pagination"></div>'
			+ '		</div>'
			+ '	</div>'
			+ '	<div>'  // < s : 좋아요나 작성 글 등등
			+ '		<div class="main2">'
			+ '			<img src="./icon/heart.png" class="good">'
			+ '			<a href="#"><img src="./icon/reply.png"></a>'
			+ '		</div>'
			+ '		<div class="main3">'
			+ '			<p>좋아요 ??개</p>'
			+ '		</div>'
			+ '		<div class="main4">'
			+ '			<a href="#">닉네임</a>'
			+ '			<span>작성글 짧게</span>'
			+ '			<div class="tabmore">'
			+ '				<div class="more">더보기</div> '
			+ '				<section class="main4block">'
			+ '					<div class="main4block2">더보기누르면 display block할 곳</div>'
			+ '				</section>'
			+ '			</div>'
			+ '		</div>'
			+ '		<div class="main5">'
			+ '			<a href="#">댓글 ?(수) 모두보기</a>'
			+ '		</div>'
			+ '		<form class="hotReply" action="#"> <!--빠르게 댓글 작성 하는 곳-->'
			+ '			<input type="text" placeholder="댓글 달기..">'
			+ '			<input type="submit" value="게시">'
			+ '		</form>'
			+ '	</div>' // e : 좋아요나 작성 글 등등
			+ '</div>';
			
			$("#maindiv").append(html);
			
			initSwiper("mySwiper")
			
	}
	function initSwiper(className){
		swiper.push( new Swiper("."+ className , 
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
		
			        