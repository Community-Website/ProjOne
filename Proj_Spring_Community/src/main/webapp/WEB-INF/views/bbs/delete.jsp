<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="uId_Session" value="${sessionScope.uId_Session }"/>

<script>
	alert("삭제되었습니다!");
	location.href = "/bbs/list?nowPage="+${nowPage};
</script>