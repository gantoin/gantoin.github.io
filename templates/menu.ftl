<!-- Fixed navbar -->
<div class="site-header" role="navigation">
    <div class="site-header__wrapper">
        <div class="site-branding">
            <a class="no-underline" href="https://gantoin.github.io"><span class="site-branding__image">Home</span></a>
            <div class="site-branding__wrapper">
                <h1 class="site-branding__title no-underline">
                    <a class="no-underline" href="https://gantoin.github.io">Antoine Gauthier</a>
                </h1>
                <p class="site-branding__description">Just a Java developer trying to brew up some good code, one
                    cup at a time.</p>
            </div>
        </div>
        <nav class="site-nav">
            <a class="site-nav__link no-underline"
               href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>index.html">Blog</a>
            <a class="site-nav__link no-underline"
               href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>about.html">About</a>
            <a class="site-nav__link no-underline"
               href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>${config.feed_file}">Subscribe</a>
            <a class="site-nav__link no-underline"
               href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>archive.html">Archive</a>
        </nav>
    </div>
</div>

<!-- Begin page content -->

<main class="content">
