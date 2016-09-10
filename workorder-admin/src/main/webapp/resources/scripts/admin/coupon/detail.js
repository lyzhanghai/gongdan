$(function(){
	$('#startUseTime').datetimepicker({
		language:  'zh-CN',
		minView: 0,
		format: "yyyy-mm-dd hh:ii:00",
        autoclose: true
	});
	$('#endUseTime').datetimepicker({
		language:  'zh-CN',
		minView: 0,
		format: "yyyy-mm-dd hh:ii:00",
        autoclose: true
	});
});

var colspan4SearchCouponUseList = 7;

/**
 * 页面初始化
 */
$(function(){
	searchCouponUseList(1);
});

$.templates({
	couponUseSearchListTpl: '<tr>' 
					   + '<td>{{:userId}}</td>'
					   + '<td>{{:mobilePhone}}</td>'
				       + '<td class="uk-font-bold uk-color-black">{{:nickName}}</td>'
					   + '<td>{{:getTime}}</td>'
					   + '<td>{{if used}}<span class="uk-label coupon-status uk-status-1">已使用</span>{{/if}}{{if !used}}<span class="uk-label coupon-status uk-status-0">未使用</span>{{/if}}</td>'
					   + '<td>{{:useTime}}</td>'
					   + '<td></td>'
				   + '</tr>'
});

/**
 * 查询优惠券使用列表
 * @param currentPage
 */
function searchCouponUseList(currentPage){
	currentPage = currentPage ? currentPage : 1;
	var form = document.couponUseSearchForm;
	form.currentPage.value = currentPage;
	var $dataList = $("#couponUseSearchList");
	var $pager = $("#couponUseSearchPager");
	$pager.hide();
	$dataList.html('<tr><td class="loading" colspan="' + colspan4SearchCouponUseList + '"><p>正在查询...</p></td></tr>');
	var html = '<tr><td class="no-result" colspan="' + colspan4SearchCouponUseList + '">没有查询到符合条件的记录.</td></tr>';
	var totalRowCount = 0;
	setTimeout(function(){
		$.ajax({
			async: true,
			cache: false,
			type: 'post',
			dataType: 'json',
			data: $(form).serialize(),
			url: CONTEXT_PATH + '/admin/coupon/use/search',
			success: function(response) {
				if (response) {
					if(response.success) {
						if(response.data && response.data.length > 0){
							html = $.render.couponUseSearchListTpl(response.data);
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
	   	   		  		onPageClick: searchCouponUseList
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