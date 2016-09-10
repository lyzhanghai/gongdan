/**
 * 浏览器窗口宽度
 */
var winWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
/**
 * 浏览器窗口高度
 */
var winHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
/**
 * 主显示区域的iframe id
 */
var iframeId = "mainFrame";
var mainFrameMinHeight = 0;

function initFrameHeight(){
	//首页头部高度
	var hdHeight = $(".uk-index-hd").outerHeight();
	//设置菜单所属区域的最小高度
	var menuHeight = $(".uk-index-treemenu-panel").outerHeight();
	mainFrameMinHeight = Math.max(winHeight - hdHeight, menuHeight);
	$(".uk-index-bd-left-content").css("min-height", mainFrameMinHeight + "px");
	adjustMainFrameHeight();
}

/**
 * 初始化菜单树被点击事件
 */
function initMenuTreeEvent(){
	var $menuTreeDiv = $(".uk-index-treemenu-panel");
	$menuTreeDiv.find("ul li > a").bind({
		"click": function(){
			var el = $(this);
			var $parentLi = el.parent("li");
			$menuTreeDiv.find("ul li").removeClass("mt-selected");
			$parentLi.addClass("mt-selected");
			var isFolder = $parentLi.hasClass("mt-folder");
			if(isFolder){
				var $childUl = $parentLi.children("ul");
				var expanded = $parentLi.hasClass("mt-expanded");
				if(expanded){
					$childUl.slideUp(300, function(){
						$parentLi.removeClass("mt-expanded");
						adjustMainFrameHeight();
					});
				}else{
					$childUl.slideDown(300, function(){
						$parentLi.addClass("mt-expanded");
						adjustMainFrameHeight();
					});
				}
			}
			
			var menuUrl = el.attr("data-menu-url");
			if(menuUrl && menuUrl != '#' && menuUrl != 'about:blank'){
				loadMenuUrl(menuUrl);
			}
		}
	});
}

/**
 * 加载url
 * @param menuUrl
 */
function loadMenuUrl(menuUrl){
	var $mainFrame = $("#" + iframeId);
	if(!menuUrl || menuUrl == '#'){
		$mainFrame.attr("src", 'about:blank');
	}else{
		if(/^http:\/\/.+$/.test(menuUrl)){
			$mainFrame.attr("src", menuUrl);
		}else{
			$mainFrame.attr("src", CONTEXT_PATH + menuUrl);
		}
	}
}

/**
 * 调整后台管理首页主区域高度
 */
function adjustMainFrameHeight(){
	var $mainFrame = $("#" + iframeId);
	var menuHeight = $(".uk-index-treemenu-panel").outerHeight();
	var frameHeight = $mainFrame.outerHeight();
	var height = menuHeight > frameHeight ? menuHeight : frameHeight;
	$mainFrame.css("min-height", height);
}

/**
 * 定时自动调整iframe的高度
 */
var marginHeight = -1;
function autoResizeMainFrameHeight(){
	var $mainFrame = $("#" + iframeId);
	var bodyHeight = $mainFrame.contents().find("body").outerHeight();
	/*if(marginHeight == -1){ //first init
		var docHeight = $($mainFrame[0].contentWindow.document).outerHeight();
		marginHeight = docHeight - bodyHeight;
		marginHeight = marginHeight > 0 ? marginHeight : 0;
	}*/
	var maxHeight = Math.max((bodyHeight + marginHeight), mainFrameMinHeight);
	$(".auto-resize").css({
		"height" : maxHeight + "px",
		"min-height" : mainFrameMinHeight + "px"
	});
}

/**
 * 文档装载完毕
 */
$(document).ready(function(){
	initFrameHeight();
	initMenuTreeEvent();
	
	$(window).resize(function(){
		adjustMainFrameHeight();
	});
	
	setInterval(autoResizeMainFrameHeight, 200);
});