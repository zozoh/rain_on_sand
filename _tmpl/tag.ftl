<html>
<head>
    <meta charset="UTF-8">
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
    <title>${doc.title}</title>
    <link rel="stylesheet" type="text/css" href="../css/tags.css">
    <script language="javascript" src="../js/jquery.js"></script>
</head>
<body>
<#include "lib:sky.ftl">
<div id="arena">
    <#list tag.items as zi>
    <div class="tag-content">
        <div class="doc-title">
            <a href="${doc.bpath}/${zi.rpath}">${zi.title}</a>
        </div>
        <div class="doc-info">
            <#if zi.author??>
                <div class="doc-authors">
                    <#if (zi.author?size)&gt;0><i>By:</i></#if>
                    <#list zi.author as au>
                    <span class="doc-author">
                        <b>${au.name}</b>
                        <#if (au.email)??><em>${au.email}</em></#if>
                    </span>
                    </#list>
                </div>
            </#if>
            <#if zi.verifier??>
                <div class="doc-verifiers">
                    <#if (zi.verifier?size)&gt;0><i>Verify By:</i></#if>
                    <#list zi.verifier as ve>
                    <span class="doc-author">
                        <b>${ve.name}</b>
                        <#if (ve.email)??><em>${ve.email}</em></#if>
                    </span>
                    </#list>
                </div>
            </#if>
        </div>
        <div class="doc-content">${zi.briefHtml}</div>
    </div>
    </#list>
</div>
</body>
</html>
