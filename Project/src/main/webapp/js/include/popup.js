

function boardModify(){
	// let bno = $('#inputBno').attr('value');
	// let nick = $('#inputMnick').attr('value'); //필요 없으면 삭제
	// $('#boardBno').attr('value', bno); // 인코딩 된 bno 필요없으면 삭제
	$('#morePopup2').modal('show');
}

function modifyOk(){
	// 수정팝업을 연다 -> (bno를 보내서) -> 할려고 했는데 창 열때 수정과 게시글 보기 class값이 같아서 킬때 자동으로 그려짐
	let bno = $('#inputBno').attr('value');
	$('#modifyBno').attr('value', bno);
	$('#morePopup2').modal('hide');
	$('#detailBoard').modal('hide');
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
					location.href = "/Dongstagram/user/"+nick; 
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


// 수정 파트
//글자 수 세주는 코드
function calc(){
  document.getElementById('modifyTextareaCount').innerHTML =
  document.getElementById('modifyTextarea').value.length;
}

//수정버튼 클릭시
function postModify(){
	let rno = $('#inputRno').attr('value');
	let bno = $('#inputBno').attr('value');
		$.ajax({
			url:"/Dongstagram/board/detailBoard.jsp", 
			type:"post",
			data : {rno : rno},
			success:function(resData){	
				if(resData.trim() == "true"){
						alert("게시글을 수정했습니다.");
						$('#modifyPopup').modal('hide');	
					} 
					if(resData.trim() == "false"){
						alert("삭제 권한이 없습니다.");
					}
			 } // success
		 });
}

function reportPopupUser() {
	
	//유저 신고
	let nick = $("#profile_nick").val();
	let reason = '';
	$.ajax({
		url:"/Dongstagram/data/report/user", 
		type:"post",
		data : {target : nick, reason:reason},
		success:function(resData){	
			if(resData.trim() == "SUCCESS")
			{
				$('#bPopup').modal('hide');
				alert("신고 완료");	
			}
		 } // success
	 });
	 
	 return false;
}

