<%@ page isErrorPage = "true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error</title>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/error.css" type="text/css" rel="stylesheet">  
</head>
<body>
<div class="page-404">
    <div class="outer">
        <div class="middle">
            <div class="inner">
                <!--BEGIN CONTENT-->
                <div class="inner-circle"><i class="fa fa-cogs"></i><span>500</span></div>
                <span class="inner-status">Opps! Internal Server Error!</span>
                <span class="inner-detail">Unfortunately we're having trouble loading the page you are looking for. Please come back in a while.</span>
                <!--END CONTENT-->
            </div>
        </div>
    </div>
</div>
</body>
</html>