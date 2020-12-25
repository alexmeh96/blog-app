<#import "part/common.ftlh" as c>
<#import "part/login.ftlh" as l>

<@c.page>
    <h1>Страница входа</h1>
    <@l.login "/login" false/>
</@c.page>