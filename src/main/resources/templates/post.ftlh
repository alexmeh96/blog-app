<#import "part/common.ftlh" as c>
<#import "part/postForm.ftlh" as p>

<@c.page>
    <div class="emp-board">

        <#if isCreate>
            <h1>Создать пост</h1>
            <@p.postForm "/post/create" true/>
        <#else>
            <h1>Изменить пост</h1>
            <#if post??>
                <@p.postForm "/post/update" false/>
            <#else >
                <p>Нет такого поста!</p>
            </#if>
        </#if>
    </div>

</@c.page>