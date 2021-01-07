<#import "part/common.ftlh" as c>
<#import "part/login.ftlh" as l>

<@c.page>
    <div class="emp-board">
        <p>Пользователь: <a href="/profile/${user.id}">${user.username}</a></p>
        <form action="/admin/user/update" method="post">
            <p>Роли: </p>
            <#list roles as role>
                <label><input type="checkbox" name="roleList"
                              value="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}
                </label>
            </#list>
            <input type="hidden" value="${user.id}" name="userId">
            <input type="hidden" value="${_csrf.token}" name="_csrf">
            <button class="btn btn-primary ms-3" type="submit">Сохранить</button>
        </form>
    </div>

</@c.page>