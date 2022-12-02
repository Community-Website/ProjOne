<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
	<c:when test="${param.joinRes ==true}">
		<script type="text/javascript">
		alert("회원가입하셨습니다.");
		location.href="/";
		</script>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
		alert("${joinRes }회원가입 중 문제가 발생했습니다. 다시 시도해주세요.\n만일 문제가 계속될 경우 고객센터(02-1234-5678)로 연락해주세요.");
		history.back();
		</script>
	</c:otherwise>
	
</c:choose>

