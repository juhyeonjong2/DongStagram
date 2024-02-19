/**
 * 
 */

	let idDupChecked = false;
	function resetIdDupCheck(){
		idDupChecked = false;
	}
	
	function checkId(){
		
		let me = $("#joinUser");
		let divParent = me.closest(".group");
		let errorSpan = divParent.find(".checkBox span");
		let value = me.val();
		
		const regId = /^[a-zA-Z0-9]*$/;
		let regRs = regId.test(value);
		
		if(value == ""){
			errorSpan.text("필수입력입니다");
			errorSpan.css("color", "red");
			return false;
		}else if(!regRs){
			errorSpan.text("영문, 숫자만 입력 가능합니다.");
			errorSpan.css("color", "red");
			return false;
		} else {
			if(!idDupChecked)
			{
				errorSpan.text("아이디 중복 확인바랍니다.");
				errorSpan.css("color", "red");
				return false;
			}
			else {
				errorSpan.text("사용가능합니다.");
				errorSpan.css("color", "green");
				return true;
			}
		}
	}	
	
	function checkDuplicateIdWithUI(o) {
		let btn = $(o);
		let divParent = btn.closest(".group");
		let errorSpan = divParent.find(".checkBox span");
		
		btn.attr("disabled",true); // 확인전에 disable
		btn.css("backgroundColor", "gray");
		
		// 연속 클릭방지용 1초 딜레이
		setTimeout(function() {
			// 중복확인버튼 잠금 해제.
			btn.removeAttr("disabled");	
			btn.css("backgroundColor", "#4EA685");
		}, 1000);
		
		
		let chk = checkDuplicateId();
		if(chk==1){
			errorSpan.text("아이디가 중복 되었습니다.");
			errorSpan.css("color", "red");
		}
		else if(chk==-1){
			errorSpan.text("공백이거나 영문, 숫자가 아닙니다.");
			errorSpan.css("color", "red");
		}
		else {
			errorSpan.text("사용가능합니다.");
			errorSpan.css("color", "green");
			idDupChecked = true;
		}
		
	}
	function checkDuplicateId(){
		
		let me = $("#joinUser");
		let value = me.val();
		
		let result = 0;
		$.ajax( 
		{
			url : "/Dongstagram/accounts/duplicate/id",
			type : "post",
			data : "id=" + value,
			async : false,
			success : function(resData) 
			{
				if(resData.trim() == 'OK')
				{
					// 아이디가 중복되었음.
					result = 1;	// 아이디 중복
				}
				else if(resData.trim() == 'ERROR')
				{
					result = -1; // 오류 : 아이디가 공백이거나 영숫자가 아님(서버에서 2차 거름)
				}
			},
			error : function() {
				//consloe.log("FAIL");
			}
		});
		
		return result;
	}
	
	function checkPassword(){
		let me = $("#joinPass");
		let divParent = me.closest(".group");
		let errorSpan = divParent.find(".checkBox span");
		let value = me.val();
		
		const regex = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,20}$/; // 대소문자, 특문, 숫자 최소 한개씩 포함 8~20자 
		let regRs = regex.test(value);
		
		if(value == ""){
			errorSpan.text("필수입력입니다");
			errorSpan.css("color", "red");
			return false;
		}else if(!regRs){
			errorSpan.text("영문 대소문자, 숫자, 특수문자 포함 8~20자입니다.");
			errorSpan.css("color", "red");
			return false;
		} else {
			errorSpan.text("사용가능합니다.");
			errorSpan.css("color", "green");
			return true;
		}
	}
	
	function checkRepassword()
	{
		let me = $("#joinRepass");
		let divParent = me.closest(".group");
		let errorSpan = divParent.find(".checkBox span");
		let value = me.val();
		
		let pw = $("#joinPass");
		let pwValue = pw.val();
		
		if(value == ""){
			errorSpan.text("필수입력입니다");
			errorSpan.css("color", "red");
			return false;
		}else if(value != pwValue){
			errorSpan.text("비밀번호가 일치하지 않습니다.");
			errorSpan.css("color", "red");
			return false;
		}else{
			errorSpan.text("사용가능합니다.");
			errorSpan.css("color", "green");
			return true;
		}
	}
	
	function checkName()
	{
		let me = $("#joinName");
		let divParent = me.closest(".group");
		let errorSpan = divParent.find(".checkBox span");
		let value = me.val();
		
		const regex = /^[가-힣a-zA-Z0-9]*$/; // 한글, 숫자, 영어만 
		let regRs = regex.test(value);
		
		if(value == ""){
			errorSpan.text("필수입력입니다");
			errorSpan.css("color", "red");
			return false;
		}else if(!regRs){
			errorSpan.text("공백없는 한글, 영문 대소문자, 숫자로 구성되어야 합니다.");
			errorSpan.css("color", "red");
			return false;
		}else{
			errorSpan.text("사용가능합니다.");
			errorSpan.css("color", "green");
			return true;
		}
	}


	let nickDupChecked = false;
	function resetNickDupCheck(){
		nickDupChecked = false;
	}
	
	function checkNick(){
		
		let me = $("#joinNick");
		let divParent = me.closest(".group");
		let errorSpan = divParent.find(".checkBox span");
		let value = me.val();
		
		const regex = /^[a-zA-Z0-9]*$/;
		let regRs = regex.test(value);
		
		if(value == ""){
			errorSpan.text("필수입력입니다");
			errorSpan.css("color", "red");
			return false;
		}else if(!regRs){
			errorSpan.text("영문, 숫자만 입력 가능합니다.");
			errorSpan.css("color", "red");
			return false;
		} else {
			if(!nickDupChecked)
			{
				errorSpan.text("닉네임 중복 확인바랍니다.");
				errorSpan.css("color", "red");
				return false;
			}
			else {
				errorSpan.text("사용가능합니다.");
				errorSpan.css("color", "green");
				return true;
			}
		}
	}	
	
	function checkDuplicateNickWithUI(o) {
		let btn = $(o);
		let divParent = btn.closest(".group");
		let errorSpan = divParent.find(".checkBox span");
		
		btn.attr("disabled",true); // 확인전에 disable
		btn.css("backgroundColor", "gray");
		
		// 연속 클릭방지용 1초 딜레이
		setTimeout(function() {
			// 중복확인버튼 잠금 해제.
			btn.removeAttr("disabled");	
			btn.css("backgroundColor", "#4EA685");
		}, 1000);
		
		
		let chk = checkDuplicateNick();
		if(chk==1){
			errorSpan.text("닉네임이 중복 되었습니다.");
			errorSpan.css("color", "red");
		}
		else if(chk==-1){
			errorSpan.text("공백이거나 영문, 숫자가 아닙니다.");
			errorSpan.css("color", "red");
		}
		else {
			errorSpan.text("사용가능합니다.");
			errorSpan.css("color", "green");
			nickDupChecked = true;
		}
		
	}
	function checkDuplicateNick(){
		
		let me = $("#joinNick");
		let value = me.val();
		
		let result = 0;
		$.ajax( 
		{
			url : "/Dongstagram/accounts/duplicate/nick",
			type : "post",
			data : "nick=" + value,
			async : false,
			success : function(resData) 
			{
				if(resData.trim() == 'OK')
				{
					// 아이디가 중복되었음.
					result = 1;	// 아이디 중복
				}
				else if(resData.trim() == 'ERROR')
				{
					result = -1; // 오류 : 아이디가 공백이거나 영숫자가 아님(서버에서 2차 거름)
				}
			},
			error : function() {
				//consloe.log("FAIL");
			}
		});
		
		return result;
	}
	
	function checkEmail()
	{
		let me = $("#joinEmail");
		let divParent = me.closest(".group");
		let errorSpan = divParent.find(".checkBox span");
		let value = me.val();
		
		const regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
		let regRs = regex.test(value);
		
		if(value == ""){
			errorSpan.text("필수입력입니다");
			errorSpan.css("color", "red");
			return false;
		}else if(!regRs){
			errorSpan.text("올바른 이메일 형식이 아닙니다.");
			errorSpan.css("color", "red");
			return false;
		} else {
			errorSpan.text("");
			//errorSpan.css("color", "green");
			return true;
		}
	}
	
	
	function sendCertNumber(o)
	{
		// 여기를 풀면 이메일 형식이 아니어도 동작함(서버에서 막음)
		if(checkEmail() == false){
			return;
		}
		
		let me = $("#joinEmail");
		let value = me.val();
		
		let btn = $(o);
		btn.attr("disabled",true); // 확인전에 disable
		btn.css("backgroundColor", "gray");
		
		// 연속 클릭방지용 1초 딜레이
		setTimeout(function() {
			// 중복확인버튼 잠금 해제.
			btn.removeAttr("disabled");	
			btn.css("backgroundColor", "#4EA685");
		}, 1000);
		
		printEmailCert("");
		showEmailCertInput(false);
		
		$.ajax( 
		{
			url : "/Dongstagram/accounts/cert/email",
			type : "get",
			data : "email=" + value,
			success : function(resData) 
			{
				let obj =JSON.parse(resData.trim());	
				if(obj.result =="SUCCESS")
				{
					// 오류 없이 데이터가 전송되었음.
					// 인증번호 입력창을 연다.
					showEmailCertInput(true);
				}
				else if(obj.result =="FAIL")
				{
					printEmailCert(obj.reason);
				}
				 
			},
			error : function() {
				
			//	consloe.log("FAIL");
			}
		});
		
	}
	
	function showEmailCertInput(bShow)
	{
		let joinCertNumber = $("#joinCertNumber");
		let joinCertNumberCheck = $("#joinCertNumberCheck");
		
		if(bShow){
			joinCertNumber.css("display","");
			joinCertNumberCheck.css("display","");
		}else {
			joinCertNumber.css("display","none");
			joinCertNumberCheck.css("display","none");
		}
	}
	
	function printEmailCert(reason){
		
		let me = $("#joinEmail");
		let divParent = me.closest(".group");
		let errorSpan = divParent.find(".checkBox span");
		
		if(reason == "ERROR"){	
		  errorSpan.text("올바른 이메일 형식이 아닙니다.");
		  errorSpan.css("color", "red");	
		}
		else if(reason == "DUP"){
			errorSpan.text("중복된 이메일 입니다.");
			errorSpan.css("color", "red");
		}
		else if(reason == "CERT_ERROR"){
			errorSpan.text("인증 오류입니다.");
			errorSpan.css("color", "red");
		}
		else if(reason == "CERT_SUCCESS"){
			errorSpan.text("인증되었습니다.");
			errorSpan.css("color", "green");
		}
		else { // 이유 삭제.
			errorSpan.text("");
		}
	}
	
	function verifyCertNumber(o)
	{
		// 여기를 풀면 이메일 형식이 아니어도 동작함(서버에서 막음)
		if(checkEmail() == false){
			return;
		}
		
		let email = $("#joinEmail");
		let emailValue = email.val();
		
		let me = $("#joinCertNumber");
		let divParent = me.closest(".group");
		let errorSpan = divParent.find(".checkBox span");
		let value = me.val();
		
		
		// 검사.
		const regex = /^[0-9]*$/; // 숫자
		let regRs = regex.test(value);
		
		if(value == ""){
			errorSpan.text("인증 번호를 입력하세요.");
			errorSpan.css("color", "red");
			return;
		}else if(!regRs){
			errorSpan.text("공백없이 숫자만 입력하세요.");
			errorSpan.css("color", "red");
			return;
		} else {
			errorSpan.text("");
		}
		
		
		let btn = $(o);
		btn.attr("disabled",true); // 확인전에 disable
		btn.css("backgroundColor", "gray");
		
		// 연속 클릭방지용 1초 딜레이
		setTimeout(function() {
			btn.removeAttr("disabled");	
			btn.css("backgroundColor", "#4EA685");
		}, 1000);
		
		$.ajax( 
		{
			url : "/Dongstagram/accounts/cert/email",
			type : "post",
			data : {email:emailValue, cert:value},
			success : function(resData) 
			{
				let obj =JSON.parse(resData.trim());	
				printEmailCert(obj.reason);
			},
			error : function() {
				//consloe.log("FAIL");
			}
		});
		
	}
	
	
	
	
	function submitValidation()
	{
		if(checkId() & checkPassword() & checkRepassword() &
		   checkName() & checkNick() & checkEmail())
		{
			return true;
		} else {
			return false;
		}
	}
	
	
	
	
	
	
	
	
	
	
	