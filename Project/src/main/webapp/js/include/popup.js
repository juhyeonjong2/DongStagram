

function boardModify(){
	let bno = $('#inputBno').attr('value');
	let nick = $('#inputMnick').attr('value'); //필요 없으면 삭제
	$('#boardBno').attr('value', bno); // 인코딩 된 bno 필요없으면 삭제
	$('#morePopup2').modal('show');
}

function modifyOk(){
	// 수정팝업을 연다 -> (bno를 보내서)
	
	$('#modifyPopup').modal('show');
}

function deleteOk(){
	let bno = $('#inputBno').attr('value');
	let nick = $('#inputMnick').attr('value'); //프로필 본인의 닉네임
	
	let deleteCon = confirm("정말로 게시글을 삭제하시겠습니까?");
	if(deleteCon){
		$.ajax({
			url:"/Dongstagram/board/detailBoard.jsp", 
			type:"post",
			data : {delBno : bno},
			dataType : "json",
			success:function(resData){	
				 if(resData == true){
					alert("게시글을 삭제하였습니다.");
					$('#morePopup2').modal('hide');
					$('#detailBoard').modal('hide');
					location.href = "'/Dongstagram/user/'"+nick; //동스타그램/유저/유저닉
				}else{
					alert("게시글 삭제에 실패하셨습니다.");
					$('#morePopup2').modal('hide');
				}
			} //success
	 	});
	}else{
		alert("게시글 삭제를 취소하셨습니다.");
		$('#morePopup2').modal('hide');
	}
}
