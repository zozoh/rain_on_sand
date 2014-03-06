<div id="sky">
    <div class="sky-wrapper">
        <div class="logo"></div>
        <div class="title">${page.title}</div>
        <ul class="others">
            <li><a href="${page.bpath}tags/others.html">${othersTag.text}</a></li>
        </ul>
        <ul class="tops">
        <#list topTags as tag>
            <li><a href="${page.bpath}tags/${tag.key}.html">${tag.text}</a></li>
        </#list>
        </ul>
    </div>
</div>