var colspan4UserActivitySignupList = 5;

var colspan4UserCouponList = 5;

function getYearMonthText(date) {
	var month = date.getMonth() + 1; 
	if(month < 10){
		month = "0" + month; 
	} 
	var val = date.getFullYear() + "-" + month;
	return val;
}

var $signinCalendar = null;
/**
 * 页面初始化
 */
$(function(){
	loadUserActivitySignupList(1); //初始化用户优惠券列表
	loadUserCuoponList(1); //初始化用户优惠券列表
	$signinCalendar = $('#signinCalendar').datetimepicker({
		language:  'zh-CN',
		minView: 2,
		maxView: 2,
		format: "yyyy-mm-dd",
        autoclose: true,
        keyboardNavigation: false
	});
	$signinCalendar.find(".datetimepicker-days > table > thead > tr:first").hide();
	$signinCalendar.find(".datetimepicker-days > table > tbody > tr > td.active").attr("class", "day");
	var nowYearMonth = getYearMonthText(new Date());
	loadUserCurMonthSiginRecordList(nowYearMonth);
});


/**
 * 加载用户该月的签到日期
 * @param yearMonth
 */
function loadUserCurMonthSiginRecordList(yearMonth) {
	var userId = $("#userId").val();
	$.ajax({
		async: true,
		cache: false,
		type: 'post',
		dataType: 'json',
		data: "userId=" + userId + "&yearMonth=" + yearMonth,
		url: CONTEXT_PATH + '/admin/user/signinrecord/list',
		success: function(response) {
			if (response) {
				if(response.success) {
					if(response.data && response.data.length > 0){
						var $daysTD = $signinCalendar.find(".datetimepicker-days > table > tbody > tr > td[class='day']");
						var len = response.data.length;
						$daysTD.each(function(){
							var el = $(this);
							var day = parseInt(el.text());
							day = yearMonth + "-" + (day < 10 ? "0" + day : "" + day);
							for(var i = 0; i < len; i++){
								if(response.data[i].signinDate == day){
									el.addClass("checked");
									break;
								}
							}
						});
					}
				}else{
					alert(response.message);
				}
			} else {
				alert('请求失败!');
			}
		},
		error: function() {
			alert('请求失败!');
			$dataList.html(html);
			$pager.find(".total-count").text('0');
			$pager.find(".pagination-num").empty();
		}
	});
}

$.templates({
	userActivitySignupListTpl: '<tr>' 
								   + '<td>{{:activity.id}}</td>'
								   + '<td>{{:activity.title}}</td>'
							       + '<td>{{:activity.startTime}}</td>'
								   + '<td>{{:activity.typeName}}</td>'
								   + '<td>{{:signupTime}}</td>'
							   + '</tr>',
	userCouponListTpl: 			'<tr>' 
								   + '<td>{{:coupon.id}}</td>'
								   + '<td>{{:coupon.title}}</td>'
							       + '<td>{{:coupon.startTime}} ~ {{:coupon.endTime}}</td>'
							       + '<td>{{:getTime}}</td>'
								   + '<td>{{:useTime}}</td>'
							   + '</tr>'
});

/**
 * 查询活动报名列表
 * @param currentPage
 */
function loadUserActivitySignupList(currentPage){
	currentPage = currentPage ? currentPage : 1;
	var form = document.userActivitySignupForm;
	form.currentPage.value = currentPage;
	var $dataList = $("#signupSearchList");
	var $pager = $("#signupSearchPager");
	$pager.hide();
	$dataList.html('<tr><td class="loading" colspan="' + colspan4UserActivitySignupList + '"><p>正在查询...</p></td></tr>');
	var html = '<tr><td class="no-result" colspan="' + colspan4UserActivitySignupList + '">没有查询到符合条件的记录.</td></tr>';
	var totalRowCount = 0;
	setTimeout(function(){
		$.ajax({
			async: true,
			cache: false,
			type: 'post',
			dataType: 'json',
			data: $(form).serialize(),
			url: form.action,
			success: function(response) {
				if (response) {
					if(response.success) {
						if(response.data && response.data.length > 0){
							html = $.render.userActivitySignupListTpl(response.data);
							totalRowCount = response.totalRowCount;
						}
					}else{
						alert(response.message);
					}
				} else {
					alert('请求失败!');
				}
				$dataList.html(html);
				
				$pager.find(".total-count").text(totalRowCount);
				if(totalRowCount > 0){
   					$pager.find(".pagination-num").pagination({
   						currentPage: currentPage,
	   	   		        items: totalRowCount,
	   	   		        itemsOnPage: form.pageSize.value,
	   	   		        cssStyle: 'bootstrap-theme bootstrap-theme-sm',
	   	   		        prevText: '&laquo;',
	   	   		        nextText: '&raquo;',
	   	   		  		onPageClick: loadUserActivitySignupList
	   	   		    });
   					$pager.show();
				}else{
					$pager.find(".pagination-num").empty();
				}
			},
			error: function() {
				alert('请求失败!');
				$dataList.html(html);
				$pager.find(".total-count").text('0');
				$pager.find(".pagination-num").empty();
			}
		});
	},1000);
}

/**
 * 查询用户优惠券列表
 * @param currentPage
 */
function loadUserCuoponList(currentPage){
	currentPage = currentPage ? currentPage : 1;
	var form = document.userCouponForm;
	form.currentPage.value = currentPage;
	var $dataList = $("#userCouponSearchList");
	var $pager = $("#userCouponSearchPager");
	$pager.hide();
	$dataList.html('<tr><td class="loading" colspan="' + colspan4UserCouponList + '"><p>正在查询...</p></td></tr>');
	var html = '<tr><td class="no-result" colspan="' + colspan4UserCouponList + '">没有查询到符合条件的记录.</td></tr>';
	var totalRowCount = 0;
	setTimeout(function(){
		$.ajax({
			async: true,
			cache: false,
			type: 'post',
			dataType: 'json',
			data: $(form).serialize(),
			url: form.action,
			success: function(response) {
				if (response) {
					if(response.success) {
						if(response.data && response.data.length > 0){
							html = $.render.userCouponListTpl(response.data);
							totalRowCount = response.totalRowCount;
						}
					}else{
						alert(response.message);
					}
				} else {
					alert('请求失败!');
				}
				$dataList.html(html);
				
				$pager.find(".total-count").text(totalRowCount);
				if(totalRowCount > 0){
   					$pager.find(".pagination-num").pagination({
   						currentPage: currentPage,
	   	   		        items: totalRowCount,
	   	   		        itemsOnPage: form.pageSize.value,
	   	   		        cssStyle: 'bootstrap-theme bootstrap-theme-sm',
	   	   		        prevText: '&laquo;',
	   	   		        nextText: '&raquo;',
	   	   		  		onPageClick: loadUserCuoponList
	   	   		    });
   					$pager.show();
				}else{
					$pager.find(".pagination-num").empty();
				}
			},
			error: function() {
				alert('请求失败!');
				$dataList.html(html);
				$pager.find(".total-count").text('0');
				$pager.find(".pagination-num").empty();
			}
		});
	},1000);
}