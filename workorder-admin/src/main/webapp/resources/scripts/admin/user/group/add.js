var validateOptions= {
		rules: {
			groupName: {
				required: true
				
			}
			
		},
		messages: {
			groupName: {
				required: '请输入群组名称!'
				
			}
			
			
		}
		
		
}

var groupAddFormValidator = $(document.groupAddForm).validate(validateOptions);

	function save(el) {
		var valid=groupAddFormValidator.form();
		if(valid){
			showLoadingText(el);
			setTimeout(function(){
				document.groupAddForm.submit();
			},1000);
		}
	
}

