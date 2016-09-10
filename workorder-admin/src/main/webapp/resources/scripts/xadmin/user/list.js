/**
 * 查询用户列表
 */
function queryUserList(){
	document.userQueryForm.orderby.value = DEFAULT_USER_QUERY_LIST_ORDER_BY;
	document.userQueryForm.order.value = DEFAULT_USER_QUERY_LIST_ORDER;
	document.userQueryForm.currentPage.value = 1;
	document.userQueryForm.submit();
}
/**
 * 修改用户状态(启用/禁用用户)
 * @param el
 * @param userId
 */
function updateUserStatus(el, userId){
	el = $(el);
	var url = null;
	var status = el.attr("data-status");
	var currStatus = null;
	var nextStatus = null;
	if(status == USER_STATUS_ENABLED.statusCode){
		url = CONTEXT_PATH + '/xadmin/user/disable';
		currStatus = USER_STATUS_ENABLED;
		nextStatus = USER_STATUS_DISABLED;
	}else if(status == USER_STATUS_DISABLED.statusCode){
		url = CONTEXT_PATH + '/xadmin/user/enable';
		currStatus = USER_STATUS_DISABLED;
		nextStatus = USER_STATUS_ENABLED;
	}
	if(url && confirm('你确定要' + nextStatus.statusName + '所选用户吗?') && isSubmitable(el)){
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'userId=' + userId,
			url : url,
			success : function(response) {
				if (response) {
					if(response.success) {
						el.closest("tr").find(".user-status").text(nextStatus.statusName).removeClass('uk-status-' + currStatus.statusCode).addClass('uk-status-' + nextStatus.statusCode);
						el.attr("data-status", nextStatus.statusCode);
						el.text(currStatus.statusName + '该用户');
					}
					alert(response.message);
				} else {
					alert('请求失败!');
				}
				afterSubmited(el);
			},
			error : function() {
				alert('请求失败!');
				afterSubmited(el);
			}
		});
	}
}

/**
 * 删除该用户
 * @param el
 * @param userId
 * @param userType
 */
function delUser(el, userId, userType){
	el = $(el);
	if(userType == USER_TYPE_SYSTEM.typeCode){
		alert(USER_TYPE_SYSTEM.typeName + '不允许删除!');
		return;
	}
	if(confirm('你确定要删除所选用户吗?') && isSubmitable(el)){
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'userId=' + userId,
			url : CONTEXT_PATH + '/xadmin/user/del',
			success : function(response) {
				if (response) {
					if(response.success) {
						el.closest("tr").remove();
					}
					alert(response.message);
				} else {
					alert('请求失败!');
				}
				afterSubmited(el);
			},
			error : function() {
				alert('请求失败!');
				afterSubmited(el);
			}
		});
	}
}