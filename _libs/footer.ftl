<div id="footer">
    <div class="footer-wrapper">
        <div class="logo"></div>
        <div class="title">${siteTitle}</div>
        <ul class="tops">
        <#list topTags as tag>
            <li><a href="${page.bpath}tags/${tag.key}.html">${tag.text}</a></li>
        </#list>
        </ul>
        <ul class="others">
            <li><a href="${page.bpath}tags/others.html">${othersTag.text}</a></li>
        </ul>
        <div class="copyright">
            zozoh &copy; 2014
        </div>
    </div>
</div>