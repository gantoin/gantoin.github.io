<#include "header.ftl">

<#include "menu.ftl">

<main class="content">
    <div class="articles">
        <#list posts as post>
            <#if (post.status == "published")>
                <article class="content-excerpt">
                    <a class="link" href="${post.uri}"><h1>${post.title}</h1></a>
                    <p>${post.date?string("dd MMMM yyyy")}</p>
                    <#list post.tags as tag>
                        <p>${tag}</p>
                    </#list>
                </article>
            </#if>
        </#list>
    </div>

    <hr/>

    <p>Older posts are available in the <a href="${content.rootpath}${config.archive_file}">archive</a>.</p>
</main>
<#include "footer.ftl">
