/**
 * 
 */

	function addImg(){
	      // 추가 버튼은 맨 아래 자식에만 존재해야 함.
	      let childCnt = $("#preview div").length;
	      
	      // 추가 버튼을 포함하여 맨 아래에 추가
	      let html = '<div class="draggable" draggable: "true">';
	      html += ' <label  for="file' + (childCnt) + '" class="changeImg"><img src="/Dongstagram/icon/replyPlus.png"></label>';
	      html += ' <img src="/Dongstagram/icon/noneImg.gif" class="thumbnailImg" onclick="previewImg(this)">'
	      html += ' <input type="file" onchange="thumbnail(event,this)" id="file' + (childCnt) + '" name="file' + (childCnt) + '" hidden="true">';
	      html += ' <button type="button" class="imgDelete" onclick="removeImg(this)">제거</button>';
	      html += '</div>';
	      $("#preview").append(html);

	      //공유버튼 활성화
	      let childCnt2 = $("#preview div").length;
	      if(childCnt2 != 0){
	        document.getElementById("dropBoxSubmit").removeAttribute("disabled");
	        document.getElementById("dropBoxSubmit").style.color ="#4EA685"
	      }else{
	        document.getElementById("dropBoxSubmit").setAttribute("disabled", true);
	        document.getElementById("dropBoxSubmit").style.color ="#aaa"
	      }

	      //썸네일 이미지 드래그 코드 1 (추가버튼을 누를때마다 추가된 div를 찾는다)
	          let = draggables = document.querySelectorAll(".draggable");
	          let = containers = document.querySelectorAll(".preview");
	          // 드래그시 dragging라는 클래스 주입 
	          draggables.forEach(draggable => {
	          draggable.addEventListener("dragstart", () => {
	            draggable.classList.add("dragging");
	          });

	          // 드래그 끝나면 dragging라는 클래스 제거 
	          draggable.addEventListener("dragend", () => {
	              draggable.classList.remove("dragging");
	            });
	          });

	          containers.forEach(container => {
	          container.addEventListener("dragover", e => {
	            e.preventDefault();
	            const afterElement = getDragAfterElement(container, e.clientY); //clientY y값으로 변경
	            const draggable = document.querySelector(".dragging");
	            if (afterElement === undefined) {
	              container.appendChild(draggable);
	            } else {
	              container.insertBefore(draggable, afterElement);
	            }
	          });
	        });
	      
	    } //추가버튼 함수 끝

	      //이미지 드래그 앤 드랍으로 순서 변경하는 코드 (연구 부족으로 일단 아래에서 위로만 드래그 가능)
	      function getDragAfterElement(container, y) {
	        const draggableElements = [
	          ...container.querySelectorAll(".draggable:not(.dragging)"),
	        ];

	        return draggableElements.reduce(
	          (closest, child) => {
	            const box = child.getBoundingClientRect();
	            const offset = y - box.top - box.width / 3; //box.left -> box.top로 변경 box.width 3으로 바꿔 감도 변경
	            if (offset < 0 && offset > closest.offset) {
	              return { offset: offset, element: child };
	            } else {
	              return closest;
	            }
	          },
	          { offset: Number.NEGATIVE_INFINITY },
	        ).element;
	    }

	    //제거 코드
	    function removeImg(e){
	      $(e).parent().remove();
		

	      //제거 시 공유하기 버튼 비활성화 
	      let childCnt2 = $("#preview div").length;
	      console.log(childCnt2)
	      if(childCnt2 != 0){
	        document.getElementById("dropBoxSubmit").removeAttribute("disabled");
	        document.getElementById("dropBoxSubmit").style.color ="#4EA685"
	      }else{
	        document.getElementById("dropBoxSubmit").setAttribute("disabled", true);
	        document.getElementById("dropBoxSubmit").style.color ="#aaa"
	      }
	        
	    };

	    //썸네일 추가 함수
	    function thumbnail(event,obj){
	      const file = event.target.files[0];
	      const img = $(obj).prev()
	       const reader = new FileReader();
	       reader.onload = (e) => {
	        $(img).attr("src", e.target?.result );
	       };
	       reader.readAsDataURL(file);
	      }


	    //글자 수 세주는 코드
	    function calc(){
	      document.getElementById('replyTextareaCount').innerHTML =
	      document.getElementById('replyTextarea').value.length;
	    }


	    //이미지 클릭시 미리보기
	    function previewImg(obj){
	      let previewSrc = $(obj).attr("src");
	      if(previewSrc != "/Dongstagram/icon/noneImg.gif"){
	        $(".dropBox").css("background-image","url("+previewSrc+")")
	        $(".dropBox").css("background-color","#111")
	      }
	    }

	    //공유하기 버튼 클릭 시 유효성 검사 코드
	    function submitCheck(){
	      // input 이름 부여 후 그 후 들어온 input의 안의 데이터에 이상한 src가 있는지 검사

	      //input의 이름을 배정해준다
	      $("#preview div input[type=file]").each(function (index, item){  //item은 preview div input[type=file]의 현재 요소, index는 인덱스 요소(위부터)
	          $(item).attr("name", "file_" + (index) );
	        });

	      //input 파일안에 이미지가 없는 경우 임시로 넣어둔 이미지가 있다면 공유하기 안되도록
	      let imgCheck = false;
	      $(".thumbnailImg").each(function (index, item){ 
	        let previewSrc = $(item).attr("src");
	        //만약 임시이미지가 잘못된 경우
	        if(previewSrc == null || previewSrc == "/Dongstagram/icon/noneImg.gif"){
	          imgCheck = false;
	          return false; //반복하는 도중 문제를 발견하면 바로 반복문 종료(마지막만 제대로된 사진일 경우 트루되버리는거 방지)
	        }else{
	          imgCheck = true
	        }
	      });

	      if(imgCheck){
	        document.postfrm.submit();
	      }else{
	        alert("이미지를 전부 넣어주세요");
	      }

	    }