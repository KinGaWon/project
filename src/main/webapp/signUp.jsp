<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>sign up</title>
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
        .signupForm{
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
            width: 300px;
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
        .label{
            color: gray;
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
        function DoSignup(){
            let NAME = document.querySelector("#name");
            let EMAIL = document.querySelector("#email");
            let ID = document.querySelector("#id");
            let NICKNAME = document.querySelector("#nickname");
            let PASSWORD = document.querySelector("#password");
            let CPW = document.querySelector("#cpw");
            //NAME
            if(NAME.value.trim() == ""){
                let msgBox = NAME.parentNode.getElementsByClassName("msgbox");
                msgBox[0].innerHTML = "<span>이름을 입력하세요</span>";
                NAME.value = "";
                NAME.focus();
                return false;
            }
            let namePatten = /^[가-힣]+$/;
            if(!namePatten.test(NAME.value)){
                let msgBox = NAME.parentNode.getElementsByClassName("msgbox");
                msgBox[0].innerHTML ="<span>한글만 입력하세요</span>";
                NAME.value = "";
                NAME.focus();
                return false;
            }
            if(NAME.value.length < 2){
                let msgBox = NAME.parentNode.getElementsByClassName("msgbox");
                msgBox[0].innerHTML = "<span>2자 이상 입력하세요</span>";
                NAME.value = "";
                NAME.focus();
                return false;
            }
            //EMAIL
            if(EMAIL.value == ""){
                let msgBox = EMAIL.parentNode.getElementsByClassName("msgbox");
                msgBox[0].innerHTML = "<span>이메일을 입력하세요</span>";
                EMAIL.value = "";
                EMAIL.focus();
                return false;
            }
            let emailPatten = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
            if(!emailPatten.test(EMAIL.value)){
                let msgBox = EMAIL.parentNode.getElementsByClassName("msgbox");
                msgBox[0].innerHTML ="<span>정확한 이메일을 입력하세요</span>";
                EMAIL.value = "";
                EMAIL.focus();
                return false;
            }
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
            //NICKNAME
            if(NICKNAME.value.trim() == ""){
                let msgBox = NICKNAME.parentNode.getElementsByClassName("msgbox");
                msgBox[0].innerHTML = "<span>닉네임을 입력하세요</span>";
                NICKNAME.value = "";
                NICKNAME.focus();
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
            //CPW
            if(PASSWORD.value != CPW.value){
                let msgBox = CPW.parentNode.getElementsByClassName("msgbox");
                msgBox[0].innerHTML = "<span>비밀번호가 일치하지 않습니다</span>";
                CPW.value = "";
                CPW.focus();
                return false;
            }
        }
        window.onload = function (){
				let inputs = document.getElementsByTagName("input");
				inputs[0].focus();

				for( let item of inputs ){
					let msgBox = item.parentElement.getElementsByClassName("msgbox");
					if( msgBox.length > 0 )
					{	
						item.onkeydown = () => {
							msgBox[0].innerHTML = "";
						};
					}

				}
            }
    </script>
</head>
<body>
    <div class="signupForm">
        <form action="signUpOk.jsp" method="post" onsubmit="return DoSignup();">
            <h2>Sign Up</h2><br>
                <label>
                    <div class="label">NAME</div>
                    <input class="input" type="text" id="name" name="name">
                    <div class="msgbox"></div>
                </label>
                <br>
                <label>
                    <div class="label">EMAIL</div>
                    <input class="input" type="email" id="email" name="email">
                    <div class="msgbox"></div>
                </label>
                <br>
                <label>
                    <div class="label">ID</div>
                    <input class="input" type="text" id="id" name="id">
                    <div class="msgbox"></div>
                </label>
                <br>
                <label>
                    <div class="label">NICKNAME</div>
                    <input class="input" type="text" id="nickname" name="nickname">
                    <div class="msgbox"></div>
                </label>
                <br>
                <label>
                    <div class="label">PASSWORD</div>
                    <input class="input" type="password" id="password" name="password">
                    <div class="msgbox"></div>
                </label>
                <br>
                <label>
                    <div class="label">CONFIRM PASSWORD</div>
                    <input class="input" type="password" id="cpw" name="cpw">
                    <div class="msgbox"></div>
                </label>
                    <input class="inputBtn" type="submit" value="Sign Up">
        </form>
        <span>이미 계정이 있으신가요?</span>
        <a href="login.jsp">login</a><br>
        <a href="index.jsp" style="font-size: small">홈으로 돌아가기</a>
    </div>
</body>
</html>