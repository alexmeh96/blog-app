<#import "part/common.ftlh" as c>
<#import "part/postForm.ftlh" as p>
<#include "part/security.ftlh">

<@c.page>
    <div class="emp-board">
        <h1>Посты</h1>
        <#if !allPosts??>
            <#if auth??>
                <p>
                    Автор: <a href="/profile/${auth.id}">${auth.username}</a>
                </p>
            <#else >
                <p>
                    Автор: <a href="/profile/${currentUserId}">Вы</a>
                </p>
            </#if>
        </#if>

        <#if posts?? >
            <#list posts as post>
                <div class="card mb-3 align-self-center" style="width: 25rem;">
                    <img src="/image/${post.imagePreviewId}" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title">${post.name}</h5>
                        <p class="card-text">${post.describe}</p>
                        <p>
                            <a href="/post/read/${post.id}" class="btn btn-primary">Читать</a>
                            <#if post.author.id == currentUserId>
                                <a href="/post/update/${post.id}">Изменить</a>
                            </#if>
                        </p>
                    </div>
                </div>
            </#list>
        <#else>
            <p>Постов пока нет!</p>
        </#if>
    </div>
</@c.page>