
/**
 * 构造座位图数据
 */
function buildSeatStatuses() {
	var $seatRows = $(".uk-table-seats tbody tr");
	var seatStatuses = [];
	if($seatRows.length){
		$seatRows.each(function(rIndex){
			var $seatCols = $(this).find("td input[type='text']");
			if($seatCols.length){
				var colStatuses = [];
				var b = false;
				$seatCols.each(function(cIndex){
					var value = this.value;
					if(!value){
						alert('请输入座位状态值!');
						$(this).focus();
						b = true;
						return false;
					}else{
						if(value != '0' && value != '1' && value != '2'){
							alert('只能输入三种值：0 或 1 或 2');
							$(this).focus();
							b = true;
							return false;
						}else{
							colStatuses.push(value);
						}
					}
				});
				if(b){
					return !b;
				}
				seatStatuses.push(colStatuses.join(","));
			}
		});
	}
	return seatStatuses;
}

/**
 * 座位单元格input失去焦点时的事件处理
 */
function onSeatStatusBlur(el) {
	var value = el.value;
	if(value){
		if(value != '0' && value != '1' && value != '2'){
			alert('只能输入三种值：0 或 1 或 2');
		}else{
			$(el).parent(".seat-box").addClass("seat-box-" + value);
		}
	}
}
/**
 * 固定 生成座位矩阵
 */
function genSeatMatrix() {
	/**
	 * var regex = /^\d+$/; var $rows = $("#rows"); var rows = $rows.val();
	 * if(!rows){ alert('请输入总行数！'); $rows.focus(); return; }
	 * if(!regex.test(rows)){ alert('总行数必须是整数！'); $rows.focus(); return; } var
	 * $cols = $("#cols"); var cols = $cols.val(); if(!cols){ alert('请输入总列数！');
	 * return; } if(!regex.test(cols)){ alert('总列数必须是整数！'); $cols.focus();
	 * return; }
	 */
	var rows =21;
	var cols =37;
	var $seatTableHead = $(".uk-table-seats thead");
	var head = '<tr>';
	for(var j = 0; j < cols; j++){
		head += '<th>' + (j + 1) + '</th>';
	}
	head += '</tr>';
	$seatTableHead.html(head);
	var $seatTableBody = $(".uk-table-seats tbody");
	$seatTableBody.empty();
	for(var i = 0; i < rows; i++){
		var html = '<tr>';
		for(var j = 0; j < cols; j++){
			if( (i==0 && j < 4) || ( i==0 && j > 32) || ((i==1||i==2||i==3||i==4||i==5) && (j <3||j>33)) ||(i==6&&(j<10||j>26)) || (i==7&& (j<5||j>31))
					||(i==8&&(j<2||j>34)) ||(i==9&&(j<1||j>35)) || (i==11&& j>35) ||(i==12&&(j<2||j>33)) ||(i==13&&(j<2||j>32) ) || 
					((i==14||i==15||i==16)&&(j<4||j> 31)) || ( i== 17&&(j<4||j>30)) || (i==18&&(j<3||j>31)) || ((i==19||i==20)&&(j<11||j>31)) || j==10||j==26
				)
					{
				
				html += '<td><div class="seat-box"><input type="text" name="status" onblur="onSeatStatusBlur(this);" value="0" readonly/></div></td>';
			}else {
				
				html += '<td><div class="seat-box"><input type="text" name="status" onblur="onSeatStatusBlur(this);" value="1" readonly/></div></td>';
			}
		
		}
		html += '</tr>';
		$seatTableBody.append(html);
	}
}