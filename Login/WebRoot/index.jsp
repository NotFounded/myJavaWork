<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>请登录/注册</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<style type="text/css">
body {
	text-align: center;
	background-color: aliceblue;
}

.top {
	text-align: right;
	font-size: 15px;
	margin-right: 20%;
	margin-top: 30px;
}

.t1 {
	position: fixed;
	left: 20%;
	top: 15px;
}

#m1 {
	width: 340px;
	height: 361px;
	background-color: #FFFFFF;
	position: fixed;
	left: 20%;
	top: 150px;
}

#m2 {
	position: fixed;
	left: 48.5%;
	top: 150px;
}

.title {
	font-size: x-large;
	color: black;
	font-weight: bold;
	font: "黑体";
	margin-top: 30px;
}

.name {
	margin-top: 20px;
	width: 200px;
	height: 40px;
}

.pwd {
	margin-top: 20px;
	width: 200px;
	height: 40px;
}

.find {
	text-decoration: none;
	font: "黑体";
	font-size: smaller;
	margin-left: 150px;
	color: darkgray;
}

.btn {
	margin-top: 10px;
	width: 85px;
	height: 40px;
	background-color: mediumseagreen;
	font-size: x-large;
	color: #FFFFFF;
	font: "黑体";
	border: mediumseagreen;
}

.btn2 {
	margin-left: 30px;
	margin-top: 10px;
	width: 85px;
	height: 40px;
	background-color: #1E90FF;
	font-size: x-large;
	color: #FFFFFF;
	font: "黑体";
	border: #1E90FF;
}
</style>
</head>
<title>欢迎登录</title>
<body>
	<div class="top">
		<a href="http://st.renren.com/"
			style="color: forestgreen; text-decoration: none;">学生团体申请入口</a>&nbsp;&nbsp;&nbsp;
		<a href="${pageContext.request.contextPath}/regist.jsp"
			style="color: darkgray ;text-decoration: none;">注册</a>&nbsp;&nbsp;&nbsp;
		<a href="http://support.renren.com/link/suggest"
			style="color: darkgray  ; text-decoration: none;">反馈意见</a>&nbsp;&nbsp;&nbsp;
		<a href="${pageContext.request.contextPath}/mypage.html" style="color: black; text-decoration: none;font-weight: bold;">返回首页</a>
	</div>
	<div class="t1" id="t1">
		<a href="http://www.renren.com/"><img src="img/reren.PNG" /></a>
	</div>
	<div class="mid">
		<form action="${pageContext.request.contextPath}/login.action"
			method="post" id="f1">
			<div id="m1" class="m1">
				<img src="img/person.jpg" /><br />
				<input placeholder="请输入用户名/邮箱" class="name" name="username" id="username" /><br /> 
				<input type="password" placeholder="请输入密码" name="password" id="password" class="pwd" maxlength="15" /><br /> 
				<a href="${pageContext.request.contextPath}/findpwd.jsp" class="find">忘记密码？</a><br />
				<input type=button value="登录" onclick="check()" class="btn">
				<input type="button" value="注册" onclick="window.location='${pageContext.request.contextPath}/regist.jsp'" class="btn2" id="btn2" /><br>
				<p align="center" style="color: red; font-size: 10" id="msg"><p>
			</div>
		</form>

		<div id="m2" class="m1">
			<a
				href="http://ebp.renren.com/ebpn/click.html?aid=1000063246000700005&mc=0%5EC0%5EC1000063246000700005%5EC0%5EC0%5EC1%5EC100%5EC1532565261%5EC1000000_2%7C0%7C1989-01-01%7C29%7C4%7C0086120000000000%7C0_0086110000000000%7C0%7C0%7C0%7C0086120000000000%5EC100000000061%5EC0%5EC%5EC%5EC-&refresh_source=0&refresh_idx=0&engine_type=&ref=http%3A%2F%2Fwww.renren.com%2Fad_100000000061&url=http%3A%2F%2Fwww.kaixin.com%2F%3Fchannel%3Drenren_banner%26abflag%3Dpic">
				<img src="img/ad.PNG" />
			</a>
		</div>
	</div>
</body>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	function check() {
		var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,50}[a-z0-9]+$");
		var username = document.getElementById('username');
		var password = document.getElementById('password');
		var boon = true;
		if (username.value == '' || password.value == '') {
			alert('用户名或密码不能为空！');
			boon = false;
		} else if (!reg.test(username.value)) {
			alert('邮箱格式不正确！');
			boon = false;
		}
		if(boon==true){
		$.ajax({
                type: "POST",
                dataType: "json",
                url: "${pageContext.request.contextPath}/login.action" ,//url
                data: $('#f1').serialize(),
                success:function(res){
                	console.log(res);
                	if(res.code=="success"){
                		window.location.href="${pageContext.request.contextPath}/addnickname.jsp"
                		
                	}else if(res.code=="fail"){
                		window.location.href="${pageContext.request.contextPath}/success.jsp"
                	}else if(res.code=="error"){
                		document.getElementById("msg").innerHTML="用户名或密码错误，请重新填写！";
                	}
                },
                error:function(){
                	alert("异常")
                }
            });	
		}
	}
</script>
</html>