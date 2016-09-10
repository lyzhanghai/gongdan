var colspan4UserRoleList = 7;
var colspan4SearchRoleList = 5;

$
		.templates({
			userRoleListTpl : '<tr>'
					+ '<td class="uk-center"><input type="checkbox" name="roleId" value="{{:roleId}}" onclick="selectRow(this);"/></td>'
					+ '<td class="bold black">{{:roleName}}</td>'
					+ '<td>{{:roleCode}}</td>'
					+ '<td>{{:roleTypeName}}</td>'
					+ '<td>{{>description}}</td>'
					+ '<td class="uk-center"><span class="uk-cell uk-center">{{:createTime}}</span></td>'
					+ '<td class="uk-center">'
					+ '<a class="uk-button uk-button-primary uk-button-small-mini" href="javascript:;" onclick="delUserRoles(this, \'{{:roleId}}\');">删除角色配置</a>'
					+ '</td>' + '</tr>',
			searchRoleListTpl : '<tr>'
					+ '<td class="uk-center"><input type="checkbox" name="roleId" value="{{:roleId}}" onclick="selectRow(this, \'searchRoleTableHead\');"/></td>'
					+ '<td class="bold black">{{:roleName}}</td>'
					+ '<td>{{:roleCode}}</td>' + '<td>{{:roleTypeName}}</td>'
					+ '<td>{{>description}}</td>' + '</tr>'
		});

/**
 * 加载用户的所有可见资源列表
 */
function loadAllUserRoleList() {
	var $userRoleList = $("#userRoleList");
	$userRoleList.html('<tr><td class="loading" colspan="'
			+ colspan4UserRoleList + '"><p>正在查询...</p></td></tr>');
	setTimeout(function() {
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'userId=' + document.userRoleConfigForm.userId.value,
			url : CONTEXT_PATH + '/xadmin/user/roles',
			success : function(response) {
				if (response) {
					if (response.success) {
						if (response.data && response.data.length) {
							$userRoleList.html($.render
									.userRoleListTpl(response.data));
						} else {
							$userRoleList
									.html('<tr><td class="no-result" colspan="'
											+ colspan4UserRoleList
											+ '">该用户暂未配置任何角色.</td></tr>');
						}
					} else {
						$userRoleList.html('<tr><td class="error" colspan="'
								+ colspan4UserRoleList + '">'
								+ response.message + '</td></tr>');
					}
				} else {
					alert('请求失败!');
				}
			},
			error : function() {
				alert('请求失败!');
			}
		});
	}, 1000);
}

var roleSelectDialog = null;

$(function() {
	loadAllUserRoleList();
	roleSelectDialog = UIkit.modal("#roleSelectWin", {
		bgclose : false,
		center : true,
		minScrollHeight : 500
	});
	roleSelectDialog.on({
		'show.uk.modal' : function(e) {
			searchRoleList(1);
		},
		'hide.uk.modal' : function(e) {
			resetForm();
			$("#searchRoleList").html(
					'<tr><td class="no-result" colspan="'
							+ colspan4SearchRoleList
							+ '">没有查询到符合条件的记录.</td></tr>')
		}
	});
});

/**
 * 打开角色选择窗口
 */
function openRoleSelectWin() {
	if (roleSelectDialog != null) {
		resetForm();

		roleSelectDialog.show();
		$(".uk-overflow-container").css('height', '500px');
	}
}
/**
 * 关闭角色选择窗口
 */
function closeRoleSelectWin() {
	if (roleSelectDialog != null) {
		resetForm();
		roleSelectDialog.hide();
	}
}

function resetForm() {
	document.roleSearchForm.reset();
	document.userRoleConfigForm.roleIds.value = '';
}

/**
 * 查询角色
 * 
 * @param currentPage
 */
function searchRoleList(currentPage) {
	currentPage = currentPage ? currentPage : 1;
	var form = document.roleSearchForm;
	form.currentPage.value = currentPage;
	var $dataList = $("#searchRoleList");
	var $pager = $("#roleSearchPager");
	$pager.hide();
	$dataList.html('<tr><td class="loading" colspan="' + colspan4SearchRoleList
			+ '"><p>正在查询...</p></td></tr>');
	var html = '<tr><td class="no-result" colspan="' + colspan4SearchRoleList
			+ '">没有查询到符合条件的记录.</td></tr>';
	var totalRowCount = 0;
	setTimeout(function() {
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : $(form).serialize(),
			url : CONTEXT_PATH + '/xadmin/role/search',
			success : function(response) {
				if (response) {
					if (response.success) {
						if (response.data && response.data.length > 0) {
							html = $.render.searchRoleListTpl(response.data);
							totalRowCount = response.totalRowCount;
						}
					} else {
						alert(response.message);
					}
				} else {
					alert('请求失败!');
				}
				$dataList.html(html);

				$pager.find(".total-count").text(totalRowCount);
				if (totalRowCount > 0) {
					$pager.find(".pagination-num").pagination({
						currentPage : currentPage,
						items : totalRowCount,
						itemsOnPage : form.pageSize.value,
						cssStyle : 'bootstrap-theme bootstrap-theme-sm',
						prevText : '&laquo;',
						nextText : '&raquo;',
						onPageClick : searchRoleList
					});
					$pager.show();
				} else {
					$pager.find(".pagination-num").empty();
				}
			},
			error : function() {
				alert('请求失败!');
				$dataList.html(html);
				$pager.find(".total-count").text('0');
				$pager.find(".pagination-num").empty();
			}
		});
	}, 1000);
}

/**
 * 添加用户-角色配置
 * 
 * @param el
 */
function addUserRoles(el) {
	el = $(el);
	var selectedRoleIds = [];
	var selectedRows = $("#searchRoleList").find(
			"tr td input[type='checkbox'][name='roleId']:checked");
	if (selectedRows && selectedRows.length) {
		selectedRows.each(function(index, ele) {
			selectedRoleIds.push(ele.value);
		});
	} else {
		alert('请选择角色!');
		return;
	}
	document.userRoleConfigForm.roleIds.value = selectedRoleIds.join(",");
	if (confirm('你确定要保存该用户-角色配置?') && isSubmitable(el)) {
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : $(document.userRoleConfigForm).serialize(),
			url : CONTEXT_PATH + '/xadmin/user/config/add',
			success : function(response) {
				if (response) {
					alert(response.message);
					if (response.success) {
						roleSelectDialog.hide();
						loadAllUserRoleList();
					}
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
 * 添加用户-角色配置
 * 
 * @param el
 * @param roleId
 */
function delUserRoles(el, roleId) {
	el = $(el);
	if (roleId) {
		document.userRoleConfigForm.roleIds.value = roleId;
	} else {
		var selectedRoleIds = [];
		var selectedRows = $("#userRoleList").find(
				"tr td input[type='checkbox'][name='roleId']:checked");
		if (selectedRows && selectedRows.length) {
			selectedRows.each(function(index, ele) {
				selectedRoleIds.push(ele.value);
			});
		} else {
			alert('请选择角色!');
			return;
		}
		document.userRoleConfigForm.roleIds.value = selectedRoleIds.join(",");
	}
	if (confirm('你确定要删除所选用户-角色配置?') && isSubmitable(el)) {
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : $(document.userRoleConfigForm).serialize(),
			url : CONTEXT_PATH + '/xadmin/user/config/del',
			success : function(response) {
				if (response) {
					alert(response.message);
					if (response.success) {
						loadAllUserRoleList();
					}
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