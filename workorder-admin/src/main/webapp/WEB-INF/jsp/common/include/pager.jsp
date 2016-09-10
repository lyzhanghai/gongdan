<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${pager != null && pager.totalRowCount > 0}">
<div class="uk-grid uk-grid-collapse">
	<div class="uk-width-1-3">
		<div class="uk-button-group-pagesize-wrap">
			共<span>${pager.totalRowCount}</span>条，每页显示&nbsp;
			<div class="uk-button-group uk-button-group-pagesize">
                <button class="uk-button ${pager.pageSize == 10 ? 'uk-active' : ''}" onclick="changePageSize(this,10,'${param.targetQueryFormId}');">10</button>
                <button class="uk-button ${pager.pageSize == 20 ? 'uk-active' : ''}" onclick="changePageSize(this,20,'${param.targetQueryFormId}');">20</button>
                <button class="uk-button ${pager.pageSize == 50 ? 'uk-active' : ''}" onclick="changePageSize(this,50,'${param.targetQueryFormId}');">50</button>
                <button class="uk-button ${pager.pageSize == 100 ? 'uk-active' : ''}" onclick="changePageSize(this,100,'${param.targetQueryFormId}');">100</button>
            </div>&nbsp;条
		</div>
	</div>
	<div class="uk-width-2-3">
		<ul class="uk-pagination uk-pagination-bootstrap uk-pagination-right">
			<c:if test="${pager.currentPage > 1}">
				<li><a href="javascript:;" onclick="jumpToPage(this,'${pager.currentPage - 1}','${param.targetQueryFormId}');" title="上一页"><i class="uk-icon-angle-double-left"></i></a></li>
			</c:if>
			<c:if test="${pager.currentPage == 1}">
               <li class="uk-disabled"><span><i class="uk-icon-angle-double-left"></i></span></li>
            </c:if>
            <c:forEach items="${pager.pageItems}" var="item">
				<c:if test="${item == null}">
					<li><span>...</span></li>
				</c:if>
				<c:if test="${item != null && item == pager.currentPage}">
					<li class="uk-active"><span>${item}</span></li>
				</c:if>
				<c:if test="${item != null && item != pager.currentPage}">
					<li><a href="javascript:;" onclick="jumpToPage(this,'${item}','${param.targetQueryFormId}');">${item}</a></li>
				</c:if>
			</c:forEach>
			<c:if test="${pager.currentPage < pager.totalPageCount}">
				<li><a href="javascript:;" onclick="jumpToPage(this,'${pager.currentPage + 1}','${param.targetQueryFormId}');" title="下一页"><i class="uk-icon-angle-double-right"></i></a></li>
			</c:if>
			<c:if test="${pager.currentPage == pager.totalPageCount}">
				<li class="uk-disabled"><span><i class="uk-icon-angle-double-right"></i></span></li>
			</c:if>
        </ul>
	</div>
</div>
</c:if>