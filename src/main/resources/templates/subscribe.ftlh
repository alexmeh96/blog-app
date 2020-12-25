<#import "part/common.ftlh" as c>
<#import "part/postForm.ftlh" as p>
<#include "part/security.ftlh">

<@c.page>
    <div class="row">
        <div class="col-5">
            <h3 class="text-center">Авторы</h3>
            <#if subscribes??>
                <#list subscribes as subscribe>
                    <div>
                        <a href="/profile/${subscribe.id}">${subscribe.username}</a>
                    </div>
                </#list>
            <#else>
                <p>Вы пока не подписаны ни на кого!</p>
            </#if>

        </div>
        <div class="col-7">
            <h3 class="text-center">Посты</h3>
            <#if posts??>
                <#list posts as post>
                    <div class="card mb-3" style="width: 18rem;">
                        <img src="..." class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">${post.name}</h5>
                            <p class="card-text">${post.text}</p>
                            <p>
                                <a href="/post/read/${post.id}" class="btn btn-primary">Читать</a>
                            </p>
                        </div>
                    </div>
                </#list>
            <#else>
                <p>Постов пока нет!</p>
            </#if>
        </div>
    </div>

</@c.page>