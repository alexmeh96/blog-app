<#import "part/common.ftlh" as c>
<#import "part/postForm.ftlh" as p>
<#include "part/security.ftlh">

<@c.page>
    <#if post??>
        <h3>Пост</h3>
        <div>
            <p>Название</p>
            ${post.name}
        </div>
        <div>
            <p>Контент</p>
            ${post.text}
        </div>
        <div>
            <p>Дата</p>
            ${post.date}
        </div>

        <div>
            <p>Автор</p>
            <a href="/profile/${post.author.id}">${post.author.username}</a>
        </div>

        <#if post.author.id == currentUserId>
            <form action="/post/delete" method="post">
                <input type="hidden" name="postId" value="${post.id}"/>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <p>
                    <button type="submit" class="btn btn-primary">Удалить</button>
                    <a href="/post/update/${post.id}">Изменить</a>
                </p>
            </form>
        </#if>

        <h3>Коментарии</h3>

        <#if comments??>
            <#list comments as comment>

            </#list>
        <#else >
            <p>комментарий пока нет!</p>
        </#if>
    <#else>
        <p>Нет такого поста!</p>
    </#if>

</@c.page>