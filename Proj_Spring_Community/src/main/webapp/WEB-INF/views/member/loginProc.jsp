<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${param.loginRes =='true' }">
	<script type="text/javascript">
		location.href="/";
	</script>
</c:if>
<c:if test="${param.loginRes !='true' }">
	<script type="text/javascript">
		alert("아이디 또는 비밀번호를 확인해주세요.");
		location.href="/member/login";
	</script>
</c:if>

