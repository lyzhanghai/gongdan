<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
	以下message会在html文档加载完毕的时候alert出来
 --%>
<c:if test="${not empty message || not empty sessionScope.message}">
	<div style="display:none;">
		<c:choose>
			<c:when test="${not empty message}">
				<input id="render-message" type="hidden" value="${message}" data-scope="request"/>
			</c:when>
			<c:when test="${not empty sessionScope.message}">
				<input id="render-message" type="hidden" value="${sessionScope.message}" data-scope="session"/>
			</c:when>
			<c:otherwise></c:otherwise>
		</c:choose>
	</div>
	<c:remove var="message" scope="request"/>
	<c:remove var="message" scope="session"/>
</c:if>

