<#import "part/common.ftlh" as c>
<#import "part/postForm.ftlh" as p>
<#include "part/security.ftlh">

<@c.page>
    <#if profile.author.id == currentUserId>
        <h1>Ваш профиль</h1>
        <a href="/profile/update">Изменить</a>
        <a href="/profile/settings">Настройки</a>

        <div>
            Email: ${profile.email}
        </div>
        <div>
            Номер телефона: ${profile.phoneNumber}
        </div>
        <h3>Мои подписчики</h3>
        <#if subscribers??>
            <#list subscribers as subscriber>
                <p>
                    <a href="/profile/${subscriber.id}">${subscriber.username}</a>
                </p>
            </#list>

        <#else>
            <p>У вас нет подписчиков</p>
        </#if>

    <#else>
        <h1>${profile.author.username}</h1>
        <div>
            <a href="/post/${profile.author.id}">Посты пользователя</a>
        </div>
        <div>
            Email: ${profile.email}
        </div>
        <div>
            Номер телефона: ${profile.phoneNumber}
        </div>

        <#if isSubscribe>
            <p>Вы подписаны на этого пользователя</p>
        <#else >
            <div class="mb-3">
                <form action="/profile/subscribe" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <input type="hidden" name="userId" value="${profile.author.id}"/>

                    <button type="submit" class="btn btn-primary">Подписаться</button>
                </form>
            </div>
        </#if>

    </#if>
</@c.page>