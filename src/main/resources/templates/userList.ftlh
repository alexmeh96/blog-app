<#import "part/common.ftlh" as c>
<#import "part/login.ftlh" as l>

<@c.page>
    <div class="emp-board">
        <h1>Список пользователей</h1>

        <#list users as user>
            <p>Пользователь: <a href="/admin/user/${user.id}">${user.username}</a></p>
        </#list>
    </div>

</@c.page>