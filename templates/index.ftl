<#include "header.ftl">

<#include "menu.ftl">

<div class="page-header">
    <h1>Blog</h1>
</div>
<ul class="post-list">
    <#list posts as post>
        <#if (post.status == "published")>
            <li class="no-list-style">
                <span class="post-meta">${post.date?string("MMMM dd, yyyy")}</span>
                <h2 class="post-title">
                    <a class="post-link no-underline" href="${post.uri}">${post.title}</a>
                </h2>
                <p class="post-summary no-margin">
                    ${post.body
                    ?replace("<h1>", "")
                    ?replace("</h1>", "")
                    ?replace("<h2>", "")
                    ?replace("</h2>", "")
                    ?replace("<h3>", "")
                    ?replace("</h3>", "")
                    ?replace("<p>", "")
                    ?replace("</p>", "")
                    ?replace("<a>", "")
                    ?replace("</a>", "")
                    ?chop_linebreak
                    ?truncate(180)}
                </p>
                <p class="post-meta">
                            <span class="icon icon-tag">
                                <svg ari    a-hidden="true" viewBox="0 0 544 512">
                                    <path d="M496 32H384c-26.4.0-63.273 15.273-81.941 33.941L113.941 254.059c-18.667 18.667-18.667 49.214.0 67.882l140.118 140.115c18.667 18.668 49.214 18.668 67.882.0l188.115-188.115C528.727 255.273 544 218.4 544 192V80C544 53.6 522.4 32 496 32zM432 192c-26.51.0-48-21.49-48-48s21.49-48 48-48 48 21.49 48 48S458.51 192 432 192z"/>
                                </svg>
                            </span>
                    <#list post.tags as tag>
                        <a class="post-content__tag small" href="/tags/${tag}.html">${tag}</a>
                    </#list>
            </li>
        </#if>
        <hr/>
    </#list>
</ul>

<p>Older posts are available in the <a href="${content.rootpath}${config.archive_file}">archive</a>.</p>
<#include "footer.ftl">
