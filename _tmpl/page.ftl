<html>
<head>
    <meta charset="UTF-8">
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
    <title>${doc.title}</title>
    <link rel="stylesheet" type="text/css" href="${doc.bpath}css/page.css">
</head>
<body>
    <div id="zdocContent">
        <div class="doc-title">${doc.title}</div>
        <div class="doc-info">
            <div class="doc-authors">
                <#if (doc.author?size)&gt;0><i>By:</i></#if>
                <#list doc.author as au>
                <span class="doc-author">
                    <b>${au.name}</b>
                    <#if (au.email)??><em>${au.email}</em></#if>
                </span>
                </#list>
            </div>
            <div class="doc-verifiers">
                <#if (doc.verifier?size)&gt;0><i>Verify By:</i></#if>
                <#list doc.verifier as ve>
                <span class="doc-author">
                    <b>${ve.name}</b>
                    <#if (ve.email)??><em>${ve.email}</em></#if>
                </span>
                </#list>
            </div>
        </div>
        ${doc.content}
    </div>
</body>
</html>