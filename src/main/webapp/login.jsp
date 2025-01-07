<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body, html{
            margin: 0px;
            padding: 0px;
            background-color: #bbc4fd;

        }
        a:link, a:visited {
            text-decoration: none;
            color: #6748fe;
        }
        .loginForm{
            background-color: white;
            border-radius: 1rem;
            text-align: center;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            width: 90%;
            max-width: 400px;
            position: fixed;
        }
        h2{
            text-align: center;
            color: #6748fe;
        }
        .input{
            background-color: white;
            border-radius: 1rem;
            border-style: dashed;
            border-color: #bbc4fd;
            padding: 10px;
            margin: 8px;
            width: 250px;
        }
        .inputBtn{
            background-color: #6748fe;
            color: white;
            border-radius: 1rem;
            border-style: none;
            padding: 10px;
            margin: 8px;
            width: 250px;
        }
        .inputBtn:hover{
            background-color: #bbc4fd;
            color: #6748fe;
        }
        span{
            font-size: smaller;
        }
        .msgbox{
            color: gray;
        }
    </style>
    <script>
    	function Dologin(){
    		let ID = document.querySelector("#id");
    		let PASSWORD = document.querySelector("#password");
    		//ID
    		let idPatten = /^[a-zA-Z0-9]+$/;
            if(ID.value.trim() == ""){
                let msgBox = ID.parentNode.getElementsByClassName("msgbox");
                msgBox[0].innerHTML = "<span>아이디를 입력하세요</span>";
                ID.value = "";
                ID.focus();
                return false;
            }
            if(!idPatten.test(ID.value)){
                let msgBox = ID.parentNode.getElementsByClassName("msgbox");
                msgBox[0].innerHTML ="<span>영문과 숫자만 입력 가능합니다</span>";
                ID.value = "";
                ID.focus();
                return false;
            }
            if(ID.value.length < 4){
                let msgBox = ID.parentNode.getElementsByClassName("msgbox");
                msgBox[0].innerHTML = "<span>4자 이상 입력하세요</span>";
                ID.value = "";
                ID.focus();
                return false;
            }
            //PASSWORD
            let passwordPatten = /^[a-zA-Z0-9_.@^]+$/;
            if(PASSWORD.value.trim() == ""){
                let msgBox = PASSWORD.parentNode.getElementsByClassName("msgbox");
                msgBox[0].innerHTML = "<span>비밀번호를 입력하세요</span>";
                PASSWORD.value = "";
                PASSWORD.focus();
                return false;
            }
            if(!passwordPatten.test(PASSWORD.value)){
                let msgBox = PASSWORD.parentNode.getElementsByClassName("msgbox");
                msgBox[0].innerHTML ="<span>영문과 숫자, 특수문자(. @ ^)만 입력 가능합니다</span>";
                PASSWORD.value = "";
                PASSWORD.focus();
                return false;
            }
            if(PASSWORD.value.length < 6){
                let msgBox = PASSWORD.parentNode.getElementsByClassName("msgbox");
                msgBox[0].innerHTML = "<span>비밀번호를 6자 이상 입력하세요</span>";
                PASSWORD.value = "";
                PASSWORD.focus();
                return false;
            }
    	}
    </script>
</head>
<body>
    <div class="loginForm">
        <form action="loginOk.jsp" method="post" onsubmit="return Dologin();">
            <h2>Login</h2>
                <input class="input" type="text" id="id" name="id" placeholder="ID">
                <div class="msgbox"></div>
                <input class="input" type="password" id="password" name="password" placeholder="PASSWORD">
                <div class="msgbox"></div>
                <input class="inputBtn" type="submit" value="Login">
            <br>
        </form>
        <span>계정이 없으신가요?</span>
        <a href="signUp.jsp">sign up</a><br>
        <a href="index.jsp" style="font-size: small">홈으로 돌아가기</a>
    </div>
</body>
</html>