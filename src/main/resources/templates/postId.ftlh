<#import "part/common.ftlh" as c>
<#import "part/postForm.ftlh" as p>
<#include "part/security.ftlh">

<style>
    html {
        font-size: 16px;
    }

    .media-body .author {
        display: block;
        font-size: 1rem;
        color: #000;
        font-weight: 700;
    }

    .media-body .metadata {
        display: block;
        color: #777;
        font-size: .8125rem;
    }

    .media-text {
        margin-bottom: 0.25rem;
    }

    .title-comments {
        font-size: 1.4rem;
        font-weight: bold;
        line-height: 1.5rem;
        color: rgba(0, 0, 0, .87);
        margin-bottom: 1rem;
        padding-bottom: .25rem;
        border-bottom: 1px solid rgba(34, 36, 38, .15);
    }

    .media-left img {
        width: 50px;
    }
</style>

<@c.page>
    <div class="emp-board">
        <#if post??>
            <div class="container mb-5">
                <h1 class="h3 text-center page-header">${post.name}</h1>
            </div>

            <div class="row mb-3">
                <div class="fr-view">
                    <#noautoesc>
                        ${post.text}
                    </#noautoesc>
                </div>
            </div>

            <div class="media-body">
                <div class="metadata">
                    <span class="date">${post.date}</span>
                </div>
            </div>

            <p>Автор: <a href="/profile/${post.author.id}">${post.author.username}</a></p>

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

            <div class="container mb-3">
                <h1 class="h3 text-center page-header">Коментарии к посту</h1>
            </div>
            <form action="/comment/create" method="post">
                <div class="form-floating mb-2">
                    <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea"
                              name="text"></textarea>
                    <label for="floatingTextarea">Коментарий</label>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                <input type="hidden" name="postId" value="${post.id}"/>
                <input type="hidden" name="userId" value="${currentUserId}"/>

                <button type="submit" class="btn btn-primary mb-3">Добавить</button>
            </form>


            <div class="container">
                <div class="comments">
<#--                    <h3 class="title-comments">Комментарии ()</h3>-->
                    <ul class="media-list">
                        <!-- Комментарий (уровень 1) -->
                        <#if comments??>
                            <#list comments as comment>

                                <li class="media">
                                    <div class="media-left">
                                        <a href="/profile/${comment.author.id}">
                                            <img class="media-object" src="/image/${comment.author.profile.avatarId}"
                                                 alt="...">
                                        </a>
                                    </div>
                                    <div class="media-body">
                                        <div class="media-heading">
                                            <div class="author">${comment.author.username}</div>
                                            <div class="metadata">
                                                <span class="date">${comment.date}</span>
                                            </div>
                                        </div>
                                        <div class="media-text text-justify">${comment.text}</div>

                                        <hr>
                                    </div>
                                </li>

                            </#list>
                        <#else >
                            <p>комментарий пока нет!</p>
                        </#if>
                    </ul>
                </div>

            </div>


        <#else>
            <p>Нет такого поста!</p>
        </#if>
    </>
</@c.page>