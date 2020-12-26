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
            <div class="fr-view">
                <#noautoesc>
                    ${post.text}
                </#noautoesc>

            </div>

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
        <form action="/comment/create" method="post">
            <div class="form-floating">
                <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea" name="text"></textarea>
                <label for="floatingTextarea">Коментарий</label>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}" />

            <input type="hidden" name="postId" value="${post.id}" />
            <input type="hidden" name="userId" value="${currentUserId}" />

            <button type="submit" class="btn btn-primary mb-3">Добавить</button>
        </form>

        <#if comments??>
            <#list comments as comment>
                <div class="mb-3">
                    <p>
                        <a href="/profile/${comment.author.id}">${comment.author.username}</a>
                    </p>
                    <p>
                        ${comment.text}
                    </p>
                </div>
            </#list>
        <#else >
            <p>комментарий пока нет!</p>
        </#if>
    <#else>
        <p>Нет такого поста!</p>
    </#if>

</@c.page>