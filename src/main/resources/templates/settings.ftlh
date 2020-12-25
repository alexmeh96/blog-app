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

            </#list>

        <#else>
            <p>У вас нет подписчиков</p>
        </#if>


    <#else>
        <h1>${profile.author.username}</h1>
        <div>
            Email: ${profile.email}
        </div>
        <div>
            Номер телефона: ${profile.phoneNumber}
        </div>
    </#if>
</@c.page>