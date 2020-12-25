<#import "part/common.ftlh" as c>
<#import "part/login.ftlh" as l>

<@c.page>
    <h1>Страница регистрации</h1>
<#--    ${message?ifExists}-->
    <@l.login "/registration" true/>
</@c.page>