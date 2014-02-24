(function($){
$(document).ready(function(){
    // 记录自己的基础连接
    var baseUrl = location.href;
    $(document.body).attr("base-url", baseUrl);
    // 修改目录里的 href
    $("#siteIndex").find("a").each(function(index,ele){
        $(ele).attr("href",baseUrl+$(ele).attr("href"));
    });
    // 绑定点击事件
    $(document.body).on("click","a",function(e){
        // 全局链接放行
        var href = $(e.target).attr("href");
        if($(e.target).parents("#siteIndex").size()==0
            && ((/^_blank$/i).test($(e.target).attr("target")))) {
            return;
        }
        
        // 否则捕获
        e.preventDefault();

        // 加载网页，并在 done 的时候保存历史
        var jDoc = $("#zdocContent");
        $.get(href).done(function(str){
            // 去掉链接
            str = str.replace(/<link[^>]+>/,"")
                     .replace(/<script[^>]+>/,"");
            // 得到页面代码
            var jq = $('<div id="__tmpl" style="display:none"></div>')
                .appendTo(document.body);
            $(str).appendTo(jq);
            // 修改链接和图片
            jq.find("img").each(function(index, ele){
                var jImg = $(ele);
                if(jImg.attr('apath'))
                    jImg.attr('src', baseUrl+"/"+jImg.attr('apath'));
            });
            jq.find("a").each(function(index, ele){
                var jA = $(ele);
                if((/https?:\/\//i).test(href))
                    jA.attr("target","_blank");
                if(jA.attr('apath'))
                    jA.attr('href', baseUrl+jA.attr('apath'));
                var href = jA.attr("href");
            });
            // 得到文档标题
            var title = jq.find(".doc-title").text();
            // 显示
            jDoc.empty();
            jDoc.append(jq.find(".doc-title"));
            jDoc.append(jq.find(".doc-info"));
            jDoc.append(jq.find("#zdocContent").children());
            // 清空临时节点
            jq.remove();
            // 保存历史
            history.pushState(null, title, href);
        });
    });
});
})(window.jQuery);