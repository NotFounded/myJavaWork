<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>输入昵称</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
		body{background-color: aliceblue;}
		.nick{height: 40px;width: 200px;}
		.sub{height: 35px;width: 95px;margin-top: 5px;background-color:#1E90FF; border: #1E90FF;}
		.b1{text-align: center;}
		.b2{font-size: 20;color: green;}
	</style>

  </head>
  
  <body>
  <div>
	  <form action="${pageContext.request.contextPath}/addNickName.action" method="post" id="f1">
	  	<div class="b1">
	  		<p class="b2">快起一个昵称吧~</p>
		    <input type="text" placeholder="请输入昵称" name="nickname" id="nickname" class="nick"> <br>
		    <input type="button" value="起好了" onclick="add()" class="sub" id="btn">
		</div>
	  </form>
  </div>
  </body>
  <script type="text/javascript">
  	function add(){
  	var con = document.getElementById("nickname").value
  		if(con==null || con==""){
	  		if(confirm('您的用户名为空，以后再说？')){
	  			document.getElementById("f1").submit();
	  		}
  		}else{
  			document.getElementById("f1").submit();
  		}
  	}
  </script>
</html>
