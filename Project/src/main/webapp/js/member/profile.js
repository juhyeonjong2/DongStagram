/**
 * 
 */
 
function load(o){
		let bno = $(o).data('id');
		$('#inputBno').attr('value',bno);
		// 가상경로로 수정(페이지 컨트롤러)
		// 파일 이미지 넣기
		$.ajax({
			url:"/Dongstagram/board/detailBoard.jsp", 
			type:"post",
			data : {shortUrl : bno},
			dataType : "json",
			success:function(resData){
				//이미지 부분
				$('.swiper-wrapper').empty();
				
				let Dongstagram = "/Dongstagram";
				let upload = "upload/";
				for(let i =0; i<resData.imglist.length; i++){
					
					let html = '<div class="swiper-slide"><img src="'
							 + Dongstagram + '/' + upload + resData.nick + '/' + resData.imglist[i].bfrealname
							 + '"></div>';
					$('.swiper-wrapper').append(html)
					
				 }
				
				$('#favorite').attr('value',resData.bno);
				$("#goodHt").addClass("good favoriteImg_"+resData.bno)
				
			 }
		 });
		
		//댓글 생성
		$.ajax({
			url:"/Dongstagram/board/detailBoard.jsp", 
			type:"post",
			data : {shortUrlReply : bno},
			dataType : "json",
			success:function(resData){
				// 댓글 부분
				$('.popupviewMain').empty();
				console.log(resData);
				if( resData.replylist.length == 0 && resData.rootReply.length == 0){
					let noneReply = '<div class="notReply">'
	                    		 + '<p>아직 댓글이 없습니다.</p>'
	                    		 + '<h6>댓글을 남겨보세요</h6>'
                				 + '</div>'
                	$('.popupviewMain').append(noneReply)	
                	console.log(1);	 
				}
				
				if(resData.rootReply[0] != undefined){
					// 여기서 맨위의 루트댓글을 그려준다.
					let rootReply = '<div class="mainTop"><img src="#" class="profile"> '
								  + '<a href="#" class="main1name">' + resData.rootReply[0].rname + '</a> '
								  + '<div class="popupViewReply">' + resData.rootReply[0].rcontent + '</div> '
								  + '</div>'
								  + '<span class="popupviewMainSpan1">' + resData.rootReply[0].pdate + '일 전</span>'
								  + '<span class="popupviewMainSpan3">| 댓글달기 |</span>'
						$('.popupviewMain').append(rootReply)
						console.log(3);
				}
					
				
					for(let i = 0; i<resData.replylist.length; i++){
						console.log(12)
						
						let html = '<div class="mainTop"><img src="#" class="profile"> '
								 + '<a href="#" class="main1name">' + resData.replylist[i].rname + '</a> '
								 + '<div class="popupViewReply">' + resData.replylist[i].rcontent + '</div> '
								 + '</div>'
								 + '<span class="popupviewMainSpan1">' + resData.replylist[i].pdate + '일 전</span>'
								 + '<span class="popupviewMainSpan3">| 댓글달기 |</span>'
								 + '<a data-toggle="modal" data-id="'+ resData.replylist[i].rno +'" onclick="deleteOpen(this)" class="popupviewMainSpan2">· · ·</a>'
						$('.popupviewMain').append(html)
					 } // for문
					 
					 // 하단부분 그리기
					 $('.popupviewBottom2').empty();
					 
					 let html = '<img src="#" class="profile"> '
						 + '  <span class="popupviewBottomSpan1">좋아요'+ resData.bfavorite +' 개</span> '
						 + '  <span class="popupviewBottomSpan2">'+ resData.cdate +'일 전</span> '

					$('.popupviewBottom2').append(html)	
				 
				 
			} //success

	 	});
			
		//swiper 생성
		var swiper = new Swiper(".mySwiper", {
			spaceBetween: 30,
			centeredSlides: true,
			pagination: {
				el: ".swiper-pagination",
				clickable: true,
			},
			navigation: {
		 		nextEl: ".swiper-button-next",
				prevEl: ".swiper-button-prev",
			},
		});
				
		// 팝업 열기
	     $('#detailBoard').modal('show');
	     
	};

	
	//댓글 엔터키
	function enterkey(o){
		// 엔터 누르면 댓글 작성
			let bno = $('#inputBno').attr('value');
			let text = $('#replyText').val();
			let nick = $('#inputMnick').attr('value');
			$.ajax({
				url:"/Dongstagram/board/replyOk.jsp",
				type:"post",
				//async:"false", 
				data : {shortUrl : bno, reply : text, nick : nick},
				success: function(data){
					if(data.trim() == "true"){
						$('#replyText').val("");
						// 댓글 다시 그리기
						$.ajax({
							url:"/Dongstagram/board/detailBoard.jsp", 
							type:"post",
							//async:"false",
							data : {shortUrlReply : bno},
							dataType : "json",
							success:function(resData){
								// 댓글 부분
								$('.popupviewMain').empty();
								
								if(resData.rootReply[0] != undefined){
									// 여기서 맨위의 루트댓글을 그려준다.
									let rootReply = '<div class="mainTop"><img src="#" class="profile"> '
												  + '<a href="#" class="main1name">' + resData.rootReply[0].rname + '</a> '
												  + '<div class="popupViewReply">' + resData.rootReply[0].rcontent + '</div> '
												  + '</div>'
												  + '<span class="popupviewMainSpan1">' + resData.rootReply[0].pdate + '일 전</span>'
												  + '<span class="popupviewMainSpan3">| 댓글달기 |</span>'
										$('.popupviewMain').append(rootReply)	
								}
								
								for(let i = 0; i<resData.replylist.length; i++){
									
									let html = '<div class="mainTop"><img src="#" class="profile"> '
											 + '<a href="#" class="main1name">' + resData.replylist[i].rname + '</a> '
											 + '<div class="popupViewReply">' + resData.replylist[i].rcontent + '</div> '
											 + '</div>'
											 + '<span class="popupviewMainSpan1">' + resData.replylist[i].pdate + '일 전</span>'
											 + '<span class="popupviewMainSpan3">| 댓글달기 |</span>'
											 + '<a data-toggle="modal" data-id="'+ resData.replylist[i].rno +'" onclick="deleteOpen(this)" class="popupviewMainSpan2">· · ·</a>'
									$('.popupviewMain').append(html)
								 } // for문
							} //success
			
					 	}); //댓글 다시그리는 ajax
					} //트루 라면 실행
				} //success
				
			}); // 댓글 엔터로 쓰는 ajax
			//swiper 생성
			var swiper = new Swiper(".mySwiper", {
				spaceBetween: 30,
				centeredSlides: true,
				pagination: {
					el: ".swiper-pagination",
					clickable: true,
				},
				navigation: {
			 		nextEl: ".swiper-button-next",
					prevEl: ".swiper-button-prev",
				},
			});
			// 다시 팝업 열기
		    $('#detailBoard').modal('show');			
			
	}
	
	// 댓글 삭제버튼 눌렀을 때
	function deleteOpen(o){
		// hidden에 rno값 집어넣고 팝업 오픈
		let rno = $(o).data('id');
		$('#inputRno').attr('value',rno);
		$('#morePopup').modal('show');
	}
	
	// 삭제 버튼 눌렀을 경우 댓글 삭제
	function replyDelete(){
		let rno = $('#inputRno').attr('value');
		let bno = $('#inputBno').attr('value');
		$.ajax({
			url:"/Dongstagram/board/detailBoard.jsp", 
			type:"post",
			data : {rno : rno},
			success:function(resData){	
				if(resData.trim() == "true"){
					//댓글을 삭제했다는 메세지와 함께 모달을 닫고 댓글창을 다시 그린다
					alert("댓글을 삭제했습니다.");
					$('#morePopup').modal('hide');
					
					// 댓글 다시 그리기
					$.ajax({
						url:"/Dongstagram/board/detailBoard.jsp", 
						type:"post",
						data : {shortUrlReply : bno},
						dataType : "json",
						success:function(resData){
							// 댓글 부분
							$('.popupviewMain').empty();
							
							// 여기서 맨위의 루트댓글을 그려준다.
							let rootReply = '<div class="mainTop"><img src="#" class="profile"> '
										  + '<a href="#" class="main1name">' + resData.rootReply[0].rname + '</a> '
										  + '<div class="popupViewReply">' + resData.rootReply[0].rcontent + '</div> '
										  + '</div>'
										  + '<span class="popupviewMainSpan1">' + resData.rootReply[0].pdate + '일 전</span>'
										  + '<span class="popupviewMainSpan3">| 댓글달기 |</span>'
								$('.popupviewMain').append(rootReply)
							
							for(let i = 0; i<resData.replylist.length; i++){
								
								let html = '<div class="mainTop"><img src="#" class="profile"> '
										 + '<a href="#" class="main1name">' + resData.replylist[i].rname + '</a> '
										 + '<div class="popupViewReply">' + resData.replylist[i].rcontent + '</div> '
										 + '</div>'
										 + '<span class="popupviewMainSpan1">' + resData.replylist[i].pdate + '일 전</span>'
										 + '<span class="popupviewMainSpan3">| 댓글달기 |</span>'
										 + '<a data-toggle="modal" data-id="'+ resData.replylist[i].rno +'" onclick="deleteOpen(this)" class="popupviewMainSpan2">· · ·</a>'
								$('.popupviewMain').append(html)
							 } // for문
						} //success
		
				 	}); //댓글 다시그리는 ajax
					
					
				} // success
				if(resData.trim() == "false"){
					alert("삭제 권한이 없습니다.");
				}
				
			 }
		 });
	}
	
	// 좋아요 누를경우 색변환 + 페이지 다시 그리기
	function setFavorite(className, toggle) {
		let bno = $('#inputBno').attr('value');
		if(toggle == 'y'){
			$("." + className).attr("src", "/Dongstagram/icon/clickheart.png");
		}
		else {
			$("." + className).attr("src", "/Dongstagram/icon/heart.png");
		}
		//좋아요 다시 그리기
		$.ajax({
			url:"/Dongstagram/board/detailBoard.jsp", 
			type:"post",
			data : {shortUrlReply : bno},
			dataType : "json",
			success:function(resData){
					 // 하단부분 그리기
					 $('.popupviewBottom2').empty();
					 
					 let html = '<img src="#" class="profile"> '
						 + '  <span class="popupviewBottomSpan1">좋아요'+ resData.bfavorite +' 개</span> '
						 + '  <span class="popupviewBottomSpan2">'+ resData.cdate +'일 전</span> '

					$('.popupviewBottom2').append(html)	
			} //success
	 	});
			
		//swiper 생성
		var swiper = new Swiper(".mySwiper", {
			spaceBetween: 30,
			centeredSlides: true,
			pagination: {
				el: ".swiper-pagination",
				clickable: true,
			},
			navigation: {
		 		nextEl: ".swiper-button-next",
				prevEl: ".swiper-button-prev",
			},
		});
				
		// 팝업 열기
	     $('#detailBoard').modal('show');
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
	
	function changeFollowButton(isFollow){
		
		let me = $("#btn-follow");
		
		if(isFollow){
			me.text("언팔로우");
			me.removeClass(); // 클래스를 모두 지우고.
			me.addClass('btn btn-secondary');
			
		}
		else {
			me.text("팔로우");
			me.removeClass(); // 클래스를 모두 지우고.
			me.addClass('btn btn-primary');
		}
	}

	function setFollowerCount(followerCount) {
		
		let msg  = '팔로워 ';
		    msg += numberToKorean(followerCount);
		    msg += '명';
		
		 $('#followerCount').html(msg);
	}
	function setFollowCount(follwingCount) {
		let msg  = '팔로우 ';
		    msg += numberToKorean(follwingCount);
		    msg += '명';
		
		 $('#followCount').html(msg);
	}
	
	function requestFollow(o){
		
		let value = $("#profile_nick").val();
		$.ajax(
			{
				url: "/Dongstagram/data/follow/request",
				type: "post",
				data: {target:value},
				success: function(resData) {
					let obj =JSON.parse(resData.trim());	
					if(obj.result =="SUCCESS")
					{
						// 팔로우/언팔로우 성공시 대상의 팔로워 숫자의 변동이 있을수 있음.
						setFollowerCount(obj.targetFollowerCount);
						
						// 버튼도 갱신할 것.
						changeFollowButton(obj.isRequestFollow);
					}
				},
				error: function() {
					//consloe.log("FAIL");
				}
			});
	}

	
function requestFollowerList(){
	
	// id = profile_nick 을찾아 nick을 얻는다.
	let value = $("#profile_nick").val();
	$.ajax(
	{
		url: "/Dongstagram/data/follow/followers",
		type: "post",
		data: {target:value},
		success: function(resData) {
			let obj =JSON.parse(resData.trim());	
			if(obj.result =="SUCCESS")
			{
				// id = followerList 를 찾아서 비운뒤에.
				let parent = $("#followerList");
				parent.empty();
				
				for(let i=0;i<obj.followers.length;i++){
					addFollowObject(parent, obj.followers[i]);
				}
			}
		},
		error: function() {
			//consloe.log("FAIL");
		}
	});
}

function requestFollowList(){
	// id = profile_nick 을찾아 nick을 얻는다.
	let value = $("#profile_nick").val();
	$.ajax(
	{
		url: "/Dongstagram/data/follow/followings",
		type: "post",
		data: {target:value},
		success: function(resData) {
			let obj =JSON.parse(resData.trim());	
			if(obj.result =="SUCCESS")
			{
				// id = followerList 를 찾아서 비운뒤에.
				let parent = $("#followingList");
				parent.empty();
				
				for(let i=0;i<obj.followings.length;i++){
					addFollowObject(parent, obj.followings[i]);
				}
			}
		},
		error: function() {
			//consloe.log("FAIL");
		}
	});
}

function addFollowObject(parent, obj){
	
	let userNick = obj.nick;
	let contextPath = "/Dongstagram";
	let mediaFolder = contextPath + "/upload/" + userNick + "/";
	let profileImagePath = contextPath +"/icon/profile.png";
	if(obj.profileImage !=null){
		profileImagePath = mediaFolder + data.profileImage;
	}
	let profileLink = contextPath + "/user/" + userNick;
	
	
	let html = '<div class="search">';
        html+= '	<img src="'+profileImagePath+'" class="profile">';
		html+= '	<a href="'+ profileLink +'"><span class="span">'+ userNick +'</span></a>';
		if(obj.followState==1){
		html+= '	<button class="btn btn-secondary" onclick="requestObjectFollow(this)")>언팔로우</button>';
		} else if(obj.followState==0){
		html+= '	<button class="btn btn-primary" onclick="requestObjectFollow(this)")>팔로우</button>';
		}
		html+= '</div>';
              
       
	parent.append(html);
}

function changeObjectFollowButton(o, isFollow){
	let me = $(o);
	
	if(isFollow){
		me.text("언팔로우");
		me.removeClass(); // 클래스를 모두 지우고.
		me.addClass('btn btn-secondary');
		
	}
	else {
		me.text("팔로우");
		me.removeClass(); // 클래스를 모두 지우고.
		me.addClass('btn btn-primary');
	}
}

function requestObjectFollow(o){
	
	let parentObj = $(o).closest(".search");
	let nickObj = parentObj.find("span.span");
	let nick = nickObj.text();
	
	$.ajax(
	{
		url: "/Dongstagram/data/follow/request",
		type: "post",
		data: {target:nick},
		success: function(resData) {
			let obj =JSON.parse(resData.trim());	
			if(obj.result =="SUCCESS")
			{
				// 버튼도 갱신할 것.
				changeObjectFollowButton(o, obj.isRequestFollow);
			}
		},
		error: function() {
			//consloe.log("FAIL");
		}
	});
}	
	
	
	
			        