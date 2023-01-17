<#include "header.ftl">

<#include "menu.ftl">
<main class="content">
    <#if (content.title)??>
        <div class="page-header">
            <h1>${content.title}</h1>
        </div>
    <#else></#if>
    <p><em>${content.date?string("dd MMMM yyyy")}</em></p>
    <div class="post-content">
        <p>${content.body}</p>
    </div>
</main>

<#include "footer.ftl">
