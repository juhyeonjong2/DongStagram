<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>설정</title>
	<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/css/setting/adminSetting.css" type="text/css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/css/member/navigation.css" type="text/css" rel="stylesheet">
	<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
</head>


<body>
<%@ include file="/include/addminSettingHeader.jsp"%>

	<main>
	<!--  이번 프로젝트에는 보류함 -->
	<div class="inner2 clearfix">
		<h3>신고된 게시물</h3>
	</div>
	
	<div id="scanMain" class="clearfix">
      <ul>
          <!--for문으로 반복될 사진 href에 자기 데이터 넣어서 표시하면 될 듯--> 
          <li class="scanimg">
            <a data-toggle="modal" href="#exampleModalCenter"><img src="./자산 4.png">
              <span class="scanimgHover">
                <span>
                  <img src="./icon/accusation.png" class="accusationImg">
                  <span>123</span>
                  <button class="blockNone2">차단</button>
                </span>
              </span>
            </a>
          </li>

          <li class="scanimg">
            <a data-toggle="modal" href="#exampleModalCenter"><img src="./자산 4.png">
              <span class="scanimgHover">
                <span>
                  <img src="./icon/accusation.png" class="accusationImg">
                  <span>123</span>
                  <button class="blockNone2">차단</button>
                </span>
              </span>
            </a>
          </li>

          <li class="scanimg">
            <a data-toggle="modal" href="#exampleModalCenter"><img src="./자산 4.png">
              <span class="scanimgHover">
                <span>
                  <img src="./icon/accusation.png" class="accusationImg">
                  <span>123</span>
                  <button class="blockNone2">차단</button>
                </span>
              </span>
            </a>
          </li>

          <li class="scanimg">
            <a data-toggle="modal" href="#exampleModalCenter"><img src="./자산 4.png">
              <span class="scanimgHover">
                <span>
                  <img src="./icon/accusation.png" class="accusationImg">
                  <span>123</span>
                  <button class="blockNone2">차단</button>
                </span>
              </span>
            </a>
          </li>

          <li class="scanimg">
            <a data-toggle="modal" href="#exampleModalCenter"><img src="./자산 4.png">
              <span class="scanimgHover">
                <span>
                  <img src="./icon/accusation.png" class="accusationImg">
                  <span>123</span>
                  <button class="blockNone2">차단</button>
                </span>
              </span>
            </a>
          </li>
      </ul>
  	</div>
	</main>
	
<!--footer-->
<%@ include file="/include/footer.jsp"%>
<!--footer-->
</body>
</html>