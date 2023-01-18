<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title><#if (content.title)??>${content.title}<#else>Antoine Gauthier</#if></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="keywords" content="">
    <meta name="generator" content="Antoine's blog">
    <link href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>css/style.css" rel="stylesheet">
    <link rel="stylesheet"
          href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/default.min.css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/highlight.min.js"></script>
    <script>hljs.initHighlightingOnLoad("base16/railscasts");</script>
    <link rel="shortcut icon" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>favicon.ico">
</head>
<body>
