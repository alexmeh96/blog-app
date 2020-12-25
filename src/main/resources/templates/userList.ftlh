<#import "part/common.ftlh" as c>
<#import "part/login.ftlh" as l>

<@c.page>
    <h1>Список пользователей</h1>

    <#list users as user>
        <p>Пользователь: <a href="/admin/user/${user.id}">${user.username}</a></p>
    </#list>

</@c.page>