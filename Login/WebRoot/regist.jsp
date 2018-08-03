<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'regist.jsp' starting page</title>
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

.mid{
	position:relative;
}

#m1 {
	position:fixed;
	left:50%;
	margin-left:-250px;
	width: 500px;
	height: 400px;
	background-color: #FFFFFF;
	position: fixed;
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
	width: 250px;
	height: 40px;
}

.pwd {
	margin-top: 20px;
	width: 250px;
	height: 40px;
}

.btn2 {
	margin-top: 35px;
	width: 360px;
	height: 40px;
	background-color: #1E90FF;
	font-size: x-large;
	color: #FFFFFF;
	font: "黑体";
	border: #1E90FF;
}
	
	</style>
  </head>
  
  <body>
     <div class="top">
		
		已有人人网账号，<a href="${pageContext.request.contextPath}/index.jsp" style="color: #1E90FF; text-decoration: none;font-weight: bold;">登录</a>
	</div>
	<div class="t1" id="t1">
		<a href="http://www.renren.com/"><img src="img/reren.PNG" /></a>
	</div>
	<div class="mid">
			<div id="m1" class="m1">
				<form name="form" method="post" id="f2">
					<h2>注册新帐号 加入人人网</h2><br /> 
					请输入邮箱：&nbsp;&nbsp;<input placeholder="请输入用户名/邮箱" class="name" name="username" id="username" /><br /> 
					请创建密码：&nbsp;&nbsp;<input type="password" placeholder="请输入不少于6位的密码" name="password" id="password" class="pwd" maxlength="15" /><br /> 
					邮箱验证码：&nbsp;&nbsp;<input type="text" name="checknum" id="checknum" maxlength="10" style="width:155px;height:40px;margin-top: 20px; ">
					<input type="button" value="发送验证码" onclick="sendCheckNum()" style="width:90px;height:40px" id="sendbtn"><br/>
					<div id="sendmsg" style="font-size: 12px;color: red; "></div>
					<input type="button" value="完 成 注 册" onclick="regist()" class="btn2" id="btn2" /><br>
					<p align="center" id="msg" style="color: red; font-size: 10"> <p>
				</form>
			</div>
	</div>
  </body>
  <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
  <script type="text/javascript">
  

  	function regist(){
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
		}else if(password.value.length<6){
			alert('密码长度小于6位！');
			boon = false;
		} else if(checknum.value == '' || checknum.value == ''){
			alert("验证码还未输入!");
			boon = false;
		}
		
		if(boon==true){
			//提交表单
  		$.ajax({
                type: "POST",
                dataType: "json",
                url: "${pageContext.request.contextPath}/regist.action" ,//url
                data: $('#f2').serialize(),
                success:function(res){
                	console.log(res);
                	if(res.code=="fail"){
                		document.getElementById("msg").innerHTML="验证码填写错误，请核对后再试";
                	}else if(res.code=="succ"){
                		alert("注册成功,跳转至登录页");
                		window.location.href="${pageContext.request.contextPath}/index.jsp"
                	}else if(res.code=="error"){
                		document.getElementById("msg").innerHTML="用户名与验证码不匹配！";	
                	}
                },
                error:function(){
                	alert("异常")
                }
            });	
		}
  	}
  	
  	
  	function sendCheckNum(){
  		var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,50}[a-z0-9]+$");
		var username = document.getElementById('username');
		var password = document.getElementById('password');
		var checknum = document.getElementById('checknum');
		var boon = true;
		if (username.value == '') {
			alert('用户名不能为空！');
			boon = false;
		} else if (!reg.test(username.value)) {
			alert('邮箱格式不正确！');
			boon = false;
		}
		//提交表单
		if(boon==true) {
			//按钮禁用
            time = 60;
            var btn = $("#sendbtn") ;
            btn.attr("disabled", true); //按钮禁止点击
            btn.val(time <= 0 ? "发送验证码" : ("" + (time) + "秒后可发送"));
            var hander = setInterval(function() {
                if (time <= 0) {
                    clearInterval(hander); //清除倒计时
                    btn.val("发送验证码");
                    btn.attr("disabled", false);
                    return false;
                } else {
                    btn.val("" + (time--) + "秒后可发送");
                }
            }, 1000);
  				//提交
  				$.ajax({
                type: "POST",
                dataType: "json",
                url: "${pageContext.request.contextPath}/sendCheckNum.action" ,//url
                data: $('#f2').serialize(),
                success:function(result){
                	console.log(result);
                	if(result.code=="succ") {
  						document.getElementById("sendmsg").innerHTML="验证码已发送";
                	}else if(result.code=="fail"){
                		btn.attr("disabled", false);
                        btn.val("发送验证码");
                        clearInterval(hander); 
                		document.getElementById("sendmsg").innerHTML="用户名已存在，请更换邮箱~";
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
