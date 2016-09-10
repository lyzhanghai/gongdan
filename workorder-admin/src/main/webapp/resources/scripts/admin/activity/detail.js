var colspan4SearchSignupList = 7;

/**
 * 页面初始化
 */
$(function(){
	searchSignupList(1);
});

$.templates({
	signupSearchListTpl: '<tr>' 
					   + '<td>{{:userId}}</td>'
					   + '<td>{{:userName}}</td>'
				       + '<td class="uk-font-bold uk-color-black">{{:name}}</td>'
					   + '<td>{{:phone}}</td>'
					   + '<td>{{:signupTime}}</td>'
					   + '<td>{{:selectedSeatNames}}</td>'
					   + '<td></td>'
				   + '</tr>'
});

/**
 * 查询活动报名列表
 * @param currentPage
 */
function searchSignupList(currentPage){
	currentPage = currentPage ? currentPage : 1;
	var form = document.signupSearchForm;
	form.currentPage.value = currentPage;
	var $dataList = $("#signupSearchList");
	var $pager = $("#signupSearchPager");
	$pager.hide();
	$dataList.html('<tr><td class="loading" colspan="' + colspan4SearchSignupList + '"><p>正在查询...</p></td></tr>');
	var html = '<tr><td class="no-result" colspan="' + colspan4SearchSignupList + '">没有查询到符合条件的记录.</td></tr>';
	var totalRowCount = 0;
	setTimeout(function(){
		$.ajax({
			async: true,
			cache: false,
			type: 'post',
			dataType: 'json',
			data: $(form).serialize(),
			url: CONTEXT_PATH + '/admin/activity/signup/search',
			success: function(response) {
				if (response) {
					if(response.success) {
						if(response.data && response.data.length > 0){
							html = $.render.signupSearchListTpl(response.data);
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
	   	   		  		onPageClick: searchSignupList
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