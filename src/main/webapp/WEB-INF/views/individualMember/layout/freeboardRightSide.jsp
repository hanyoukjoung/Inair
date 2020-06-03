<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">

.sidenav {
  width: 200px;
  position: absolute;
  z-index: 1;
  top: 500px;
  left: 100px;
  background: white;
  border-right:1px solid lightgrey;
  overflow-x: hidden;
  padding: 8px 0;
}

.sidenav a {
  padding: 6px 8px 6px 16px;
  text-decoration: none;
  font-size: 15px;
  color: black;
  display: block;
}

.sidenav a:hover {
  color: #206dfb;
}
@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
</style>
</head>
<body>
<div class="sidenav">
  <a href="/mentorboard/mentorboardHome.do">멘토/멘티 게시판</a>
  <a href="/freeboard/freeboardHome.do">취업자유게시판</a>
  <a href="/resboard/indvdlResboardHome.do">자료실</a>
  <a href="/noticeboard/noticeHome.do">공지사항</a>
</div>
</body>
</html>