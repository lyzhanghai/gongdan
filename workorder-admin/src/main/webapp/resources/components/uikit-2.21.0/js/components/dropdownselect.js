/*! UIkit 2.21.0 | http://www.getuikit.com | (c) 2014 YOOtheme | MIT License */
/*
 * Dropdown select component
 */
(function(addon) {

    var component;
    
    if (window.UIkit) {
        component = addon(UIkit);
    }
    
    if (typeof define == "function" && define.amd) {
        define("uikit-dropdownselect", ["uikit"], function(){
            return component || addon(UIkit);
        });
    }

})(function(UI){

    "use strict";
    
    UI.component('dropdownselect', {

        defaults: {
        	/**
    		 * 组件是否可用
    		 */
    		disabled: false,
    		/**
    		 * 组件是否可下拉
    		 */
    		readonly: false,
    		/**
    		 * 组件确定按钮样式class
    		 */
    		okBtnClass: 'uk-ok',
    		/**
    		 * 组件取消按钮样式class
    		 */
    		cancelBtnClass: 'uk-cancel',
    		/**
    		 * 组件中item样式class
    		 */
    		itemClass: 'uk-attr'
        },

        boot: function() {
            // init code
            UI.ready(function(context) {
                UI.$("[data-uk-dropdownselect]", context).each(function(){
                    var ele = UI.$(this);
                    if (!ele.data("dropdownselect")) {
                        var obj = UI.dropdownselect(ele, UI.Utils.options(ele.attr("data-uk-dropdownselect")));
                    }
                });
            });
        },

        init: function() {
            var $this = this;

            this.disabled = this.options.disabled;
            this.readonly = this.options.readonly;
            this.dropdown = this.element.children(".uk-dropdownselect-content");
            this.items = this.dropdown.find("." + this.options.itemClass)
            
            this._render();
        },

        _render: function() {
        	var $this = this;
        	
        	this.element.removeClass("uk-dropdownselect-focus");
        	this.dropdown.css("display", "none");
        	this.element.children("input[type='text']").on("click",function(){
        		this.blur();
        	});
        	if(this.readonly){
        		this.element.addClass("uk-dropdownselect-readonly");
        	}else if(this.disabled){
        		this.element.addClass("uk-dropdownselect-disabled");
        	}else{
        		this.on("click.uikit.dropdownselect",function(e){
        			var $target = UI.$(e.target);
        			if(!$target.is("." + $this.options.okBtnClass + ",." + $this.options.cancelBtnClass)){ //
        				if(!$this.element.is(".uk-dropdownselect-focus")){
            				$this.show();
            			}
        			}
        		});
        		UI.$html.on("click.uikit.dropdownselect",function(e){
        			var $target = UI.$(e.target);
        			if(!$target.parents(".uk-dropdownselect").length){
        				$this.hide();
        			}
        		});
        		this.dropdown.find("." + this.options.okBtnClass).on("click",function(e){
        			$this.trigger('ok.click.uk.dropdownselect', [$this]);
        		});
        		this.dropdown.find("." + this.options.cancelBtnClass).on("click",function(e){
        			$this.trigger('cancel.click.uk.dropdownselect', [$this]);
        		});
        		this.dropdown.find("." + this.options.itemClass).on("click",function(e){
        			$this.trigger('item.click.uk.dropdownselect', [$this, this]);
        		});
        	}
        },

        show: function() {
        	var $this = this;
        	if(!this.element.is(".uk-dropdownselect-focus")){
				this.element.addClass("uk-dropdownselect-focus");
				this.dropdown.slideDown(200, function(){
					$this.trigger('show.uk.dropdownselect', [$this]);
	        	});
			}
        },
        
        hide: function() {
        	var $this = this;
        	if(this.element.is(".uk-dropdownselect-focus")){
				this.element.removeClass("uk-dropdownselect-focus");
				this.dropdown.slideUp(200, function(){
					$this.trigger('hide.uk.dropdownselect', [$this]);
	        	});
			}
        },
        
        setRawValue: function(value) {
        	this.element.children("input[type='text']").val(value);
        },
        
        setHiddenValue: function(value) {
        	this.element.children("input[type='hidden']").val(value);
        }
    });

    return UI.dropdownselect;
});
