/**
 * 
 */
 
 function load(o){
		let bno = $(o).data('id');
		$('#inputBno').attr('value',bno);
		// 가상경로로 수정(페이지 컨트롤러)
		// 파일 이미지 넣기
		$.ajax({
			url:"<%=request.getContextPath()%>/member/detailBoard.jsp", 
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
				
			 }
		 });
		
		//댓글 생성
		$.ajax({
			url:"<%=request.getContextPath()%>/member/detailBoard.jsp", 
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
							  + '<span class="popupviewMainSpan1">' + resData.rootReply[0].previousDate + '일 전</span>'
							  + '<span class="popupviewMainSpan3">| 댓글달기 |</span>'
							  + '<a data-toggle="modal" href="#morePopup" class="popupviewMainSpan2">· · ·</a>'
					$('.popupviewMain').append(rootReply)
				
				for(let i = 0; i<resData.replylist.length; i++){
					
					let html = '<div class="mainTop"><img src="#" class="profile"> '
							 + '<a href="#" class="main1name">' + resData.replylist[i].rname + '</a> '
							 + '<div class="popupViewReply">' + resData.replylist[i].rcontent + '</div> '
							 + '</div>'
							 + '<span class="popupviewMainSpan1">' + resData.replylist[i].previousDate + '일 전</span>'
							 + '<span class="popupviewMainSpan3">| 댓글달기 |</span>'
							 + '<a data-toggle="modal" href="#morePopup" class="popupviewMainSpan2">· · ·</a>'
					$('.popupviewMain').append(html)
				 } // for문
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
				url:"<%=request.getContextPath()%>/member/replyOk.jsp",
				type:"post",
				//async:"false", 
				data : {shortUrl : bno, reply : text, nick : nick},
				success: function(data){
					if(data.trim() == "true"){
						$('#replyText').val("");
						// 댓글 다시 그리기
						$.ajax({
							url:"<%=request.getContextPath()%>/member/detailBoard.jsp", 
							type:"post",
							//async:"false",
							data : {shortUrlReply : bno},
							dataType : "json",
							success:function(resData){
								$('.popupviewMain').empty();
								// 여기서 맨위의 루트댓글을 그려준다.
								let rootReply = '<div class="mainTop"><img src="#" class="profile"> '
											  + '<a href="#" class="main1name">' + resData.rootReply[0].rname + '</a> '
											  + '<div class="popupViewReply">' + resData.rootReply[0].rcontent + '</div> '
											  + '</div>'
											  + '<span class="popupviewMainSpan1">' + resData.rootReply[0].previousDate + '일 전</span>'
											  + '<span class="popupviewMainSpan3">| 댓글달기 |</span>'
											  + '<a data-toggle="modal" href="#morePopup" class="popupviewMainSpan2">· · ·</a>'
											  
									$('.popupviewMain').append(rootReply)
			
								for(let i = 0; i<resData.replylist.length; i++){
									
									let html = '<div class="mainTop"><img src="#" class="profile"> '
											 + '<a href="#" class="main1name">' + resData.replylist[i].rname + '</a> '
											 + '<div class="popupViewReply">' + resData.replylist[i].rcontent + '</div> '
											 + '</div>'
											 + '<span class="popupviewMainSpan1">' + resData.replylist[i].previousDate + '일 전</span>'
											 + '<span class="popupviewMainSpan3">| 댓글달기 |</span>'
											 + '<a data-toggle="modal" href="#morePopup" class="popupviewMainSpan2">· · ·</a>'
									 			 
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
			        