<div class="doc-info">
    <#if doc.authors??>
        <div class="doc-authors">
            <#if (doc.authors?size)&gt;0><i>By:</i></#if>
            <#list doc.authors as au>
            <span class="doc-author">
                <b>${au.name}</b>
                <#if (au.email)??><em>${au.email}</em></#if>
            </span>
            </#list>
        </div>
    </#if>
    <#if doc.verifiers??>
        <div class="doc-authors">
            <#if (doc.verifiers?size)&gt;0><i>By:</i></#if>
            <#list doc.verifiers as au>
            <span class="doc-author">
                <b>${au.name}</b>
                <#if (au.email)??><em>${au.email}</em></#if>
            </span>
            </#list>
        </div>
    </#if>
</div>