/**
 * 文档装载完毕
 */
$(function(){
	alertMessage();
	initScrollContainerWidth();
});

function initScrollContainerWidth(){
	var el = $(".uk-table-scroll-container");
	if(el.length){
		var target = el.attr("data-relative-target");
		if(target){
			var $target = $(target);
			if($target.length){
				var w = $target.width();
				el.width(w);
			}
		}
	}
}
/**
 * 提示响应消息,如：'保存成功!','删除失败!(错误信息:...)'
 */
function alertMessage(){
	var $renderMessage = $("#render-message");
	if($renderMessage.length){
		alert($renderMessage.val());
	}
}

/**
 * DateTimePicker插件全局语言设置
 */
if($.fn.datetimepicker){
	$.extend($.fn.datetimepicker.defaults, {
		language: 'zh-CN'
	});
}
/**
 * jquery.validate默认配置
 */
if($.validator){
	$.extend($.validator.defaults, {
		ignore: ".uk-validate-ignore",
		messageClass: "uk-validate-message", // must be required
		messageTextClass: "uk-validate-message-text", // must be required
		tipsClass: "uk-validate-message-tips",
		errorClass: "uk-validate-message-error",
		validClass: "uk-validate-message-valid"
	});
}
/**
 * 排序按钮被点击
 * @param el			- 被点击的元素
 * @param orderby		- 排序字段
 * @param targetFormId	- 查询<form/>的id
 */
function changeOrderBy(el, orderby, targetFormId){
	el = $(el);
	var tableElement = el.closest(".uk-table");
	var tbodyElement = tableElement.children("tbody");
	if(tbodyElement.children("tr").length){
		var targetForm = null;
		if(targetFormId){
			targetForm = $("#" + targetFormId);
		}
		if(!targetForm.length){
			targetForm = el.clostst("form");
		}
		if(targetForm.length){
			targetForm = targetForm.get(0);
			if(orderby){
				var order = el.hasClass("desc") ? "asc" : "desc";
				el.closest("tr").find(".orderby").removeClass("asc").removeClass("desc");
				el.addClass(order);
				
				targetForm.orderby.value = orderby;
				targetForm.order.value = order.toUpperCase();
				targetForm.currentPage.value = 1;
				targetForm.submit();
			}
		}
	}
}

/**
 * 排序按钮被点击
 * @param el			- 被点击的元素
 * @param orderby		- 排序字段
 * @param callback		- 执行查询的函数名或函数
 * @param targetFormId	- 查询<form/>的id
 */
function changeOrderByAjax(el, orderby, callback, targetFormId){
	el = $(el);
	var tableElement = el.closest(".uk-table");
	var tbodyElement = tableElement.children("tbody");
	if(tbodyElement.children("tr").length){
		var targetForm = null;
		if(targetFormId){
			targetForm = $("#" + targetFormId);
		}
		if(!targetForm.length){
			targetForm = el.clostst("form");
		}
		if(targetForm.length){
			targetForm = targetForm.get(0);
			if(orderby){
				var callbackFunction = null;
				if(typeof(callback) === 'string'){
					callbackFunction = window[callback];
				}else if(typeof(callback) === 'function'){
					callbackFunction = callback;
				}
				if(callbackFunction){
					var order = el.hasClass("desc") ? "asc" : "desc";
					el.closest("tr").find(".orderby").removeClass("asc").removeClass("desc");
					el.addClass(order);
					
					targetForm.orderby.value = orderby;
					targetForm.order.value = order.toUpperCase();
					targetForm.currentPage.value = 1;
					callbackFunction.call(this);
				}
			}
		}
	}
}
/**
 * 分页方法-更改每页显示条数
 * @param el			- 被点击的元素
 * @param pageSize		- 每页显示多少条
 * @param targetFormId	- 查询<form/>的id
 */
function changePageSize(el, pageSize, targetFormId){
	el = $(el);
	if(targetFormId){
		var targetForm = $("#" + targetFormId);
		if(targetForm.length){
			targetForm = targetForm.get(0);
			if(!el.hasClass("uk-active")){
				el.siblings(".uk-button").removeClass("uk-active");
				el.addClass("uk-active");
				targetForm.pageSize.value = pageSize;
				targetForm.currentPage.value = 1;
				targetForm.submit();
			}
		}
	}
}
/**
 * 分页方法-更改每页显示条数
 * @param el			- 被点击的元素
 * @param pageSize		- 每页显示多少条
 * @param callback		- 执行查询的函数名或函数
 * @param targetFormId	- 查询<form/>的id
 */
function changePageSizeAjax(el, pageSize, callback, targetFormId){
	el = $(el);
	var targetForm = null;
	if(targetFormId){
		targetForm = $("#" + targetFormId);
	}
	if(!targetForm.length){
		targetForm = el.clostst("form");
	}
	if(targetForm.length){
		targetForm = targetForm.get(0);
		var callbackFunction = null;
		if(typeof(callback) === 'string'){
			callbackFunction = window[callback];
		}else if(typeof(callback) === 'function'){
			callbackFunction = callback;
		}
		if(callbackFunction){
			if(!el.hasClass("uk-active")){
				el.siblings(".uk-button").removeClass("uk-active");
				el.addClass("uk-active");
				
				targetForm.pageSize.value = pageSize;
				targetForm.currentPage.value = 1;
				callbackFunction.call(this);
			}
		}
	}
}
/**
 * 分页方法-跳向哪一页
 * @param el			- 被点击的元素
 * @param pageNum		- 跳转到的页码数
 * @param targetFormId	- 查询<form/>的id
 */
function jumpToPage(el, pageNum, targetFormId) {
	el = $(el);
	var targetForm = null;
	if(targetFormId){
		targetForm = $("#" + targetFormId);
	}
	if(!targetForm.length){
		targetForm = el.clostst("form");
	}
	if(targetForm.length){
		targetForm = targetForm.get(0);
		if(targetForm.length){
			if(pageNum && /^[1-9]{1}\d*$/.test(pageNum)){
				targetForm.currentPage.value = pageNum;
				targetForm.submit();
			}
		}
	}
}
/**
 * 选中当前数据列表行
 * @param el
 * @param headTableId		- 表头table id(可选参数)
 */
function selectRow(el, headTableId){
	var checked = el.checked;
	el = $(el);
	var currentTRElement = el.closest("tr");
	currentTRElement.toggleClass("selected", checked);
	var firstTdElements = currentTRElement.closest("tbody").find("tr td:first-child");
	var headTableElement = null;
	var bodyTableElement = el.closest(".uk-table");
	if(headTableId){
		headTableElement = $("#" + headTableId);
		if(headTableElement.length == 0){
			headTableElement = null;
		}
	}
	if(!headTableElement){
		headTableElement = bodyTableElement;
	}
	var selectAllCheckBoxElement = headTableElement.find("thead tr th:first-child input[type='checkbox']");
	if(firstTdElements.length && firstTdElements.length == firstTdElements.find("input[type='checkbox']:checked").length){
		if(selectAllCheckBoxElement[0]){
			selectAllCheckBoxElement[0].checked = true;
		}
	}else{
		if(selectAllCheckBoxElement[0]){
			selectAllCheckBoxElement[0].checked = false;
		}
	}
	updateSelectedRowCount(headTableElement, bodyTableElement);
}

/**
 * 选中所有行
 * @param el
 * @param bodyTableId		- 表体table id(可选参数)
 */
function selectAllRow(el, bodyTableId){
	var checked = el.checked;
	el = $(el);
	var headTableElement = el.closest(".uk-table");
	var bodyTableElement = null;
	if(bodyTableId){
		bodyTableElement = $("#" + bodyTableId);
		if(bodyTableElement.length == 0){
			bodyTableElement = null;
		}
	}
	if(!bodyTableElement){
		bodyTableElement = headTableElement;
	}
	bodyTableElement.find("tbody tr td:first-child input[type='checkbox']").each(function(){
		this.checked = checked;
		if(checked){
			$(this).closest("tr").addClass("selected");
		}else{
			$(this).closest("tr").removeClass("selected");
		}
	});
	updateSelectedRowCount(headTableElement, bodyTableElement);
}
/**
 * 更新选中记录数
 * @param headTableElement
 * @param bodyTableElement
 */
function updateSelectedRowCount(headTableElement, bodyTableElement){
	var el = headTableElement.find("thead tr td .selected-row-count");
	if(el.length){
		var selectedCount = bodyTableElement.find("tbody tr td:first-child input[type='checkbox']:checked").length;
		if(selectedCount == 0){
			el.removeClass("marked").empty();
		}else{
			el.addClass("marked").html('已选中' + selectedCount + '条记录');
		}
	}
}
/**
 * 判断按钮是否正在提交中
 * @param el
 * @returns {Boolean}
 */
function isSubmiting(el){
	el = $(el);
	if(el.attr("data-submiting")){
		return true;
	}else{
		return false;
	}
}
/**
 * 判断是否表单是否可以提交,如果可提交则设置提交标志
 * (注意：该语句请在最后提交请求时调用)
 * @param el
 * @param prompt
 * @param message
 * @returns {Boolean}
 */
function isSubmitable(el, prompt, message){
	el = $(el);
	if(el.attr("data-submiting")){
		if(prompt){
			message = message || '请不要重复提交!';
			alert(message);
		}
		return false;
	}else{
		el.attr("data-submiting", "true");
		return true;
	}
}
/**
 * 表单提交后去掉提交标志
 * @param el
 */
function afterSubmited(el){
	$(el).removeAttr("data-submiting");
}

/**
 * 清空查询条件
 * @param id
 */
function clearAll(selector){
    if (!selector) {
    	selector = ".uk-condition";
    }
    $(':input', selector).not(":button,:reset,:submit,:hidden").val("");
}
/**
 * 显示loading文本
 * @param el
 */
function showLoadingText(el){
	el = $(el);
	el.attr("data-original-text", el.text());
	el.text(el.attr("data-loading-text"));
}
/**
 * 显示loading文本
 * @param el
 */
function showOrginalText(el){
	el = $(el);
	el.text(el.attr("data-original-text"));
}
function getTotalPageCount(totalRowCount, pageSize){
	return Math.ceil(totalRowCount / pageSize) ? Math.ceil(totalRowCount / pageSize) : 1;
}