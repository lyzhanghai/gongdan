/**
 * @author pengpeng
 */
(function($){
	
	var delegate = {
		
		randomID : function(){
			var returnVal = '';
			var _alphArray = ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
			for(var i = 0; i < 6; i++){
				returnVal = _alphArray[Math.floor(Math.random() * _alphArray.length)] + returnVal;
			}
			return returnVal;
		},
			
		/**
		 * 初始化组件
		 */
		initComponent: function(options){
			options = $.extend({}, $.fn.xupload.defaults, options);
			options = $.meta ? $.extend({}, options, this.data()) : options;
			this.data("options", options);
			
			delegate.initOptions.call(this);
			delegate._render.call(this);
			delegate._bindEvent.call(this);
		},
		/**
		 * 初始化设置
		 */
		initOptions: function(){
			var options = this.data("options");
			var $file = this.children("input[type='file']");
			if($file.length){
				options.disabled = options.disabled || this.hasClass(options.xuploadBtnReadonlyClass) || $file[0].disabled;
				options.readonly = options.disabled ? false : (options.readonly || this.hasClass(options.xuploadBtnDisabledClass) || $file[0].readonly);
				
				if(options.uploadForm){
					if(typeof(options.uploadForm) == 'string'){
						options.uploadForm = $("#" + options.uploadForm);
					}else{
						options.uploadForm = $(options.uploadForm);
					}
					if(options.uploadForm.find("input[type='hidden'][name='uploadSerialNo']").length == 0){
						options.uploadForm.append('<input type="hidden" name="uploadSerialNo"/>');
					}
				}else{
					$.error("'uploadForm' config not found!");
				}
				if(options.uploadListWrapper){
					if(typeof(options.uploadListWrapper) == 'string'){
						options.uploadListWrapper = $("#" + options.uploadListWrapper);
					}else{
						options.uploadListWrapper = $(options.uploadListWrapper);
					}
				}
			}else{
				$.error("No <input type='file'/> field found!");
			}
		},
		/**
		 * 组件渲染
		 * @returns
		 */
		_render: function(){
			var options = this.data("options");
			var $file = this.children("input[type='file']");
			
			if(options.disabled){
				$file[0].disabled = false;
				$file.css("display", "none");
			}
			
			options.id = delegate.randomID();
			$file.attr("id", options.uploadFileIdPrefix + options.id);
			this.attr("id", options.uploadBtnIdPrefix + options.id);
			options.createUploadList.call(this);
			
			if(typeof(options.onInit) == 'function'){
				options.onInit.call(this, delegate, options);
			}
			this.toggleClass($.fn.xupload.defaults.xuploadBtnReadonlyClass, options.readonly);
			this.toggleClass($.fn.xupload.defaults.xuploadBtnDisabledClass, options.disabled);
			
			options.reset = delegate.reset;
		},
		/**
		 * 给组件绑定click事件
		 */
		_bindEvent: function(){
			var $this = this;
			this.children("input[type='file']").bind({
				"change": function(){
					var $file = $(this);
					var options = $this.data("options");
					var originalFileName = $.trim($file.val());
					if(originalFileName){
						var fileName = originalFileName.toLowerCase();
						var suffix = fileName.substring(fileName.lastIndexOf('.') + 1);
						var formats = "," + options.fileFormats.join(",") + ",";
						if(formats.indexOf("," + suffix + ",") != -1){
							var $uploadBoxList = $("#" + options.uploadListIdPrefix + options.id);
							if(options.maxUpload > 0){
								if($uploadBoxList.children("div").length >= options.maxUpload){
									alert(delegate.format(options.maxUploadTips, options.maxUpload));
									delegate.reset.call($this);
									return;
								}
							}
							var uploadSerialNo = delegate.randomID();
							options.uploadForm.find("input[type='hidden'][name='uploadSerialNo']").val(uploadSerialNo);
							$file.appendTo(options.uploadForm);
							options.uploadForm.attr("target", options.uploadIframeNamePrefix + uploadSerialNo);
							options.createUploadBox.call($this, $uploadBoxList, uploadSerialNo, true);
							var $uploadBox = $("#" + uploadSerialNo);
							delegate._bindBoxEvent.call($this, $uploadBox);
							$uploadBox.attr("data-xuploadbtn-id", options.uploadBtnIdPrefix + options.id);
							if(options.beforeUpload.call($this, $file, $uploadBox, uploadSerialNo)){
								setTimeout(function(){
									options.uploadForm.submit();
									delegate.reset.call($this);
								}, 1000);
							}else{
								delegate.reset.call($this);
							}
						}else{
							alert(delegate.format(options.fileFormatTips, options.fileFormats.join(",")));
							delegate.reset.call($this);
							return;
						}
					}
				}
			});
		},
		/**
		 * 给文件box绑定事件(删除、移动)
		 */
		_bindBoxEvent: function($uploadBox){
			var $this = this;
			var options = $this.data("options");
			$uploadBox.find("a > i").bind({
				"click": function(){
					options.onUploadBoxRemove.call($this, $uploadBox, $(this));
				}
			});
			if(options.moveable){
				$uploadBox.find("." + options.uploadMoveLeftClass).bind({
					"click": function(){
						var $item = $(this).closest("." + options.xuploadBoxClass);
						$item.insertBefore($item.prev("." + options.xuploadBoxClass));
					}
				});
				$uploadBox.find("." + options.uploadMoveRightClass).bind({
					"click": function(){
						var $item = $(this).closest("." + options.xuploadBoxClass);
						$item.insertAfter($item.next("." + options.xuploadBoxClass));
					}
				});
			}
		},
		/**
		 * 重置组件
		 */
		reset: function(){
			var options = this.data("options");
			var $file = this.children("input[type='file']");
			if($file.length){
				$file.appendTo(options.uploadForm);
			}
			options.uploadForm[0].reset();
			$file = options.uploadForm.find("input[type='file']");
			$file.appendTo(this);
		},
		
		/**
		 * 格式化
		 * 调用方法 
		 * var tpl = "算术：{0} 加 {0} = {1}"; 
         * var exp = $.format(tpl, 1, 2); 
         * alert(exp); 
		 * 
		 */
		format: function(source, params) {
			if (arguments.length == 1)
				return function() {
					var args = $.makeArray(arguments);
					args.unshift(source);
					return $.format.apply(this, args);
				};
			if (arguments.length > 2 && params.constructor != Array) {
				params = $.makeArray(arguments).slice(1);
			}
			if (params.constructor != Array) {
				params = [ params ];
			}
			$.each(params, function(i, n) {
				source = source.replace(new RegExp("\\{" + i + "\\}", "g"), n);
			});
			return source;
		}
	};
	
	$.fn.xupload = function(method){
		// Method calling logic
		if (delegate[method] && method.charAt(0) != '_' && method.indexOf("init") != 0) {
			return delegate[method].apply(this, Array.prototype.slice.call(arguments, 1));
		} else if (typeof method === 'object' || !method) {
			return this.each(function(){
				delegate.initComponent.call($(this), method);
			});
		} else {
			$.error('Method ' +  method + ' does not exist on jquery.xupload');
		}
	};
	
	/**
	 * 组件默认配置
	 */
	$.fn.xupload.defaults = $.extend({}, {
		/**
		 * 上传组件按钮的样式class
		 */
		xuploadBtnClass: "xupload-btn",
		/**
		 * 上传组件列表的样式class
		 */
		xuploadListClass: "xupload-list",
		/**
		 * 上传组件列表的额外样式class,用于特殊化列表的样式
		 */
		xuploadListExtClass: null,
		/**
		 * 上传组件列表中文件预览box样式
		 */
		xuploadBoxClass: "xupload-box",
		/**
		 * 上传组件按钮readonly样式class
		 */
		xuploadBtnReadonlyClass: "xupload-btn-readonly",
		/**
		 * 上传组件按钮disabled样式class
		 */
		xuploadBtnDisabledClass: "xupload-btn-disabled",
		/**
		 * 正在上传的loading样式
		 */
		uploadingClass: "xupload-uploading",
		/**
		 * 上传出错的样式
		 */
		uploadErrorClass: "xupload-error",
		/**
		 * 文件列表前后移动样式
		 */
		uploadMoveClass: "xupload-move",
		/**
		 * 文件列表前后移动样式
		 */
		uploadMoveLeftClass: "xupload-move-left",
		/**
		 * 文件列表前后移动样式
		 */
		uploadMoveRightClass: "xupload-move-right",
		/**
		 * 组件是否可以点击,如<div class="xupload-btn xupload-btn-readonly">
		 */
		readonly: false,
		/**
		 * 组件是否可用,如<div class="xupload-btn xupload-btn-disabled">
		 */
		disabled: false,
		/**
		 * 文件是否可以前后移动
		 */
		moveable: false,
		/**
		 * 删除时予以提醒?
		 */
		confirmOnRemove: false,
		/**
		 * 最多允许上传几个文件,0或负数表示不限制
		 */
		maxUpload: 0,
		/**
		 * 上传文件个数超出时的提示信息
		 */
		maxUploadTips: "对不起,最多只能上传{0}个文件!",
		/**
		 * 上传所允许的文件类型
		 */
		fileFormats: ["jpg", "jpeg", "png"],
		/**
		 * 选择文件格式不符时的提示消息
		 */
		fileFormatTips: "上传文件格式必须是{0}中的一种!",
		/**
		 * 上传文件的按钮的id前缀
		 */
		uploadBtnIdPrefix: "xupload-btn-",
		/**
		 * 上传文件的<input type='file'/>域的id前缀
		 */
		uploadFileIdPrefix: "xupload-file-",
		/**
		 * 上传文件的文件预览列表的id前缀
		 */
		uploadListIdPrefix: "xupload-list-",
		/**
		 * 上传的文件的form的target的id前缀,后缀则是上传批次号uploadSerialNo
		 */
		uploadIframeNamePrefix: "xupload-iframe-",
		/**
		 * 上传文件的文件预览列表的直接父元素,
		 * 值可以是dom对象,jquery对象或id
		 */
		uploadListWrapper: null,
		/**
		 * 上传form,初始值可以是<form/>的dom对象,jquery对象或<form/>的id
		 */
		uploadForm: null,
		/**
		 * 组件初始化结束后调用
		 * @param delegate
		 * @param options
		 */
		onInit: function(delegate, options){},
		/**
		 * 创建上传文件预览列表的div
		 */
		createUploadList: function(){
			var $this = this;
			var options = $this.data("options");
			var html = '<div id="' + options.uploadListIdPrefix + options.id + '" class="' + options.xuploadListClass + (options.xuploadListExtClass ? ' ' + options.xuploadListExtClass : '') + '"></div>';
			if(options.uploadListWrapper){
				options.uploadListWrapper.attr("id", options.uploadListIdPrefix + options.id);
				options.uploadListWrapper.addClass(options.xuploadListClass + (options.xuploadListExtClass ? ' ' + options.xuploadListExtClass : ''));
				options.uploadListWrapper.find("." + options.xuploadBoxClass).each(function(){
					delegate._bindBoxEvent.call($this, $(this));
				});
			}else{
				$this.before(html);
			}
		},
		/**
		 * 创建上传文件的预览box
		 * @param $uploadBoxList 上传预览列表
		 * @param uploadSerialNo 本次上传序列号
		 * @param uploading true/false
		 */
		createUploadBox: function($uploadBoxList, uploadSerialNo, uploading){
			var options = this.data("options");
			var html = '<div class="' + options.xuploadBoxClass + '" id="' + uploadSerialNo + '">'
							+ '<a class="' + (uploading ? options.uploadingClass : '') + '" href="javascript:;"><i title="删除"></i></a>'
							+ (options.moveable ? '<div class="' + options.uploadMoveClass + '"><a class="' + options.uploadMoveLeftClass + '" href="javascript:;">&nbsp;</a><a class="' + options.uploadMoveRightClass + '" href="javascript:;">&nbsp;</a></div>' : '')
							+ '<iframe id="' + options.uploadIframeNamePrefix + uploadSerialNo + '" name="' + options.uploadIframeNamePrefix + uploadSerialNo + '" style="display:none;"></iframe>'
					 + '</div>';
			$uploadBoxList.append(html);
			var $uploadBox = $("#" + uploadSerialNo);
			return $uploadBox;
		},
		/**
		 * @param $file 文件域
		 * @param $uploadBox 已创建的文件的预览box
		 * @param uploadSerialNo 上传序列号 
		 * @return true:会真正触发form.submit来上传数据,false取消上传
		 */
		beforeUpload: function($file, $uploadBox, uploadSerialNo){
			return true;
		},
		/**
		 * @param $uploadBox 上传文件后的相应预览box
		 * @param $removeElement 删除图标[X]元素
		 */
		onUploadBoxRemove: function($uploadBox, $removeElement){
			$uploadBox.remove();
		},
		/**
		 * 上传结果回调函数
		 * @param $uploadBox 上传文件后的相应预览box
		 * @param resultObj 上传结果对象
		 */
		uploadCallback: function($uploadBox, resultObj){
			alert("'uploadCallback' function must be specified!");
		}
	});
})(jQuery);