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
<title>欢迎回来</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<style type="text/css">
body {
	background-color: aliceblue;
}

.ex {
	position: absolute;
	right: 100px;
	font-size: 15px;
	margin: 5px;
}

#ss {
	width: 100px;
	height: 100px;
	background: #1E90FF;
	opacity: 1;
}

#pp {
	position: absolute;
	left: 10px;
	top: 150px;
}

.btn {
	width: 80px;
	height: 30px;
	background-color: #1E90FF;
	color: #FFFFFF;
	border: #1E90FF;
}

.ax {
	margin-top: 40px;
}

.low {
	margin-top: 40px;
}

.cc {
	background-color:#1E90FF;
	width: 0px;
	height: 0px;
	position: absolute;
	cursor: move;
	border-radius: 0px;
}
</style>
</head>

<body>
	<div>
		<a href="${pageContext.request.contextPath}/logOut.action"
			onclick="return confirm('确认退出登录？')" class="ex">退出登录</a>
	</div>
	<div align="center">
		<p style="font-size: 50;color:#1E90FF;">欢迎进入首页~</p>
	</div>

	<div id="pp">
		<div id="ss"></div>
		<div id="wh">
		<form onsubmit="sub()">
			<input type="number" id="width" placeholder="宽度（默认值100）" onkeyup="keyup()" /> <br> 
		    <input type="submit" value="提交">  
		</form>	
			<input id="height" maxlength="3" placeholder="高度（默认值100）" />
		</div>
		<div id="col">
			<input id="color" maxlength="15" placeholder="颜色（默认值#1E90FF）" />
		</div>
		<div id="opa">
		    <form onsubmit="sub()">
			<input type="number" step="0.01" id="opacity" maxlength="15" placeholder="透明度（默认值1）" />
		    <input type="submit" value="提交">
		    </form>
		</div>
		<div id="pos">
			<input id="left" maxlength="3" placeholder="左边距（默认值10）" /><br /> 
			<input id="top" maxlength="3" placeholder="上边距（默认值150）" />
		</div>
		<div class="ax">
			<div>
				<p>点击查看当前登录的用户信息</p>
				<input type="button" onclick="lookInfo()" class="btn" value="点击查看">
			</div>
			<div id="info"></div>
		</div>
		<div class="low">
			<p>在右侧空白处点击鼠标并拖动绘制圆形，可随意拖动</p>
		</div>
	</div>


</body>
 <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<script>
	//js原生ajax
	function lookInfo() {
		var con = $("#info").html(); 
		console.log(con);
		if(con==""||con==null){
			$.ajax({
                type: "get",
                dataType: "json",
                url: "${pageContext.request.contextPath}/lookInfo.action" ,//url
                success:function(data){
                	console.log(data);
                	if(data.code=="notExist"){
                	document.getElementById("info").innerHTML="您的昵称还未设置！&nbsp;&nbsp;<a href='/Login/addnickname.jsp'>前往设置</a>"
                	}else {
                	document.getElementById("info").innerHTML="您的用户名为："+data.code+"&nbsp;&nbsp;<a href='/Login/addnickname.jsp'>前往更改</a>";
                	}
                },
                error:function(){
                	alert("异常")
                }
            });	
		}else{
			alert("用户信息已经显示！");
		}
	}

	//控制div
	//封装通过id获取元素的方法
	function getId(id) {
		return document.getElementById(id);
	}
	//控制宽度
	getId("width").onkeyup = function() {
		/* if (this.value.length == 1) {
			this.value = this.value.replace(/\D/g, '')
		} else {
			this.value = this.value.replace(/\D/g, '')
			this.value.rep
		} */
		if (getId("width").value == null || getId("width").value == "") {
			//默认值
			getId("ss").style.width = "100px";
		}
		getId("ss").style.width = this.value + "px";
	}
	getId("width").onafterpaste = function() {
		if (this.value.length == 1) {
			this.value = this.value.replace(/\D/g, '')
		} else {
			this.value = this.value.replace(/\D/g, '')
		}
	}
	//控制高度
	getId("height").onkeyup = function() {
		if (this.value.length == 1) {
			this.value = this.value.replace(/\D/g, '')
		} else {
			this.value = this.value.replace(/\D/g, '')
		}
		if (getId("height").value == null || getId("height").value == "") {
			//默认值
			getId("ss").style.height = "100px";
		}
		getId("ss").style.height = this.value + "px";
	}
	getId("height").onafterpaste = function() {
		if (this.value.length == 1) {
			this.value = this.value.replace(/\D/g, '')
		} else {
			this.value = this.value.replace(/\D/g, '')
		}
	}
	//控制颜色
	getId("color").onkeyup = function() {
			//开头以#或大小写字母，后边为数字或大小写字母
			//this.value = this.value.replace(/^([^#|^(a-zA-Z)]\d?)|\d{12,}$/g, '')
		this.value = this.value.replace(/^[^#|^(a-zA-Z)]*/, '');
			//this.value = this.value.replace(/(^[^#]|[^a-zA-Z])\D*|[^a-zA-Z)]*$/g, '');
		if (getId("color").value == null || getId("color").value == "") {
			//默认值
			getId("ss").style.background = "#1E90FF";
		}
		getId("ss").style.background = this.value ;
	}
	getId("color").onafterpaste = function() {
		this.value = this.value.replace(/^[^#|^(a-zA-Z)]*/, '');
	}
	//控制透明度
	getId("opacity").onkeyup = function() {
		/* //清除"数字"和"."以外的字符
		this.value = this.value.replace(/[^\d.]/g, "");
		//验证第一个字符是数字 
		this.value = this.value.replace(/^\./g, "");
		//只保留第一个, 清除多余的
		this.value = this.value.replace(/\.{2,}/g, ".");
		this.value = this.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
		//只能输入两个小数
		this.value = this.value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3'); */
		if (getId("opacity").value == null || getId("opacity").value == "") {
			//默认值
			getId("ss").style.opacity = "1";
		}
		getId("ss").style.opacity = this.value ;
	}
	getId("opacity").onafterpaste = function() {
		//清除"数字"和"."以外的字符
		this.value = this.value.replace(/[^\d.]/g, "");
		//验证第一个字符是数字 
		this.value = this.value.replace(/^\./g, "");
		//只保留第一个, 清除多余的
		this.value = this.value.replace(/\.{2,}/g, ".");
		this.value = this.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
		//只能输入两个小数
		this.value = this.value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3');
	}
	//控制左边距
	getId("left").onkeyup = function() {
		if (this.value.length == 1) {
			this.value = this.value.replace(/\D/g, '')
		} else {
			this.value = this.value.replace(/\D/g, '')
			this.value.rep
		}
		if (getId("left").value == null || getId("left").value == "") {
			//默认值
			getId("pp").style.left = "10px";
		}
		getId("pp").style.left = this.value + "px";
	}
	getId("left").onafterpaste = function() {
		if (this.value.length == 1) {
			this.value = this.value.replace(/\D/g, '')
		} else {
			this.value = this.value.replace(/\D/g, '')
		}
	}
	//控制上边距
	getId("top").onkeyup = function() {
		if (this.value.length == 1) {
			this.value = this.value.replace(/\D/g, '')
		} else {
			this.value = this.value.replace(/\D/g, '')
			this.value.rep
		}
		if (getId("top").value == null || getId("top").value == "") {
			//默认值
			getId("pp").style.top = "150px";
		}
		getId("pp").style.top = this.value + "px";
	}
	getId("top").onafterpaste = function() {
		if (this.value.length == 1) {
			this.value = this.value.replace(/\D/g, '')
		} else {
			this.value = this.value.replace(/\D/g, '')
		}
	}

	//js画圆  画圆方法 参数为圆的id和classname
	function Draw(cirId, classname) {
		// startX, startY 为鼠标点击时初始坐标
		// moveX, moveY 为鼠标初始坐标与  左上角坐标之差，用于拖动
		var startX,
			startY,
			moveX,
			moveY;
		// 是否拖动，初始为 false
		var move = false;
		// 鼠标按下事件（设置圆的起始位置）
		document.onmousedown = function(e) {
			startX = e.pageX;
			startY = e.pageY;
			// 如果鼠标在 圆上被按下
			if (e.target.className.match(/cc/)) {
				// 允许拖动
				move = true;
				if (document.getElementById("move_cir") !== null) {
					//元素不为空说明第二次鼠标按下  移除第一次的id 防止拖动产生冲突
					document.getElementById("move_cir").removeAttribute("id");
				}
				//重置div的id值
				e.target.id = "move_cir";
				// 计算坐标差值
				moveX = startX - e.target.offsetLeft;
				moveY = startY - e.target.offsetTop;
			} else {
				var circle = document.createElement("div");
				circle.id = cirId ;
				circle.className = classname ;
				circle.style.top = startY + 'px';
				circle.style.left = startX + 'px';
				document.body.appendChild(circle);
				circle = null;

			}
		};
		// 鼠标移动事件（设置圆的宽 高）保持div为正方形  小的坐标为宽和高
		document.onmousemove = function(e) {
			// 更新 圆尺寸
			if (document.getElementById("cir") !== null) {
				var ab = document.getElementById("cir");
				var ww = e.pageX - ab.offsetLeft;
				var tt = e.pageY - ab.offsetTop;
				if (ww >= tt) {
					ab.style.width = tt + "px";
					ab.style.height = tt + "px";
					ab.style.borderRadius = tt / 2 + "px";
				} else {
					ab.style.width = ww + "px";
					ab.style.height = ww + "px";
					ab.style.borderRadius = ww / 2 + "px";
				}
			}
			// 移动，更新圆的位置
			if (document.getElementById("move_cir") !== null && move) {
				var mb = document.getElementById("move_cir");
				mb.style.top = e.pageY - moveY + 'px';
				mb.style.left = e.pageX - moveX + 'px';
			}
		};
		// 鼠标抬起
		document.onmouseup = function(e) {
			// 禁止拖动
			move = false;
			if (document.getElementById("cir") !== null) {
				var ab = document.getElementById("cir");
				ab.removeAttribute("id");
				// 如果长宽均小于 3px，移除 圆
				if (ab.offsetWidth < 3 || ab.offsetHeight < 3) {
					document.body.removeChild(ab);
				}
			}
		};
	};
	var draw = new Draw("cir", "cc");
</script>
</html>
