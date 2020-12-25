<#import "part/common.ftlh" as c>
<#import "part/postForm.ftlh" as p>
<#include "part/security.ftlh">

<@c.page>
    <h1>Страница настроек</h1>
    <form action="/profile/settings/username" method="post" class="needs-validation" novalidate>
        <div class="mb-3">
            <label for="exampleInputEmail1" class="form-label">Username</label>
            <input type="text" class="form-control" id="exampleInputEmail1" name="username"
                   required placeholder="username" value="${user.username}"
            >
            <div class="invalid-feedback">
                Поле не должно быть пустым
            </div>

            <input type="hidden" name="_csrf" value="${_csrf.token}"/>

            <div>
                <button type="submit" class="btn btn-primary mt-3">Обновить</button>
            </div>
        </div>
    </form>
    <form action="/profile/settings/password" method="post" class="needs-validation" novalidate>

        <div class="mb-3">
            <label for="exampleInputPassword1" class="form-label">Пароль</label>
            <input type="password" class="form-control" id="exampleInputPassword1" name="password" required
                   placeholder="пароль"
            >
            <div class="invalid-feedback">
                Поле не должно быть пустым
            </div>

            <input type="hidden" name="_csrf" value="${_csrf.token}"/>

            <div>
                <button type="submit" class="btn btn-primary mt-3">Обновить</button>
            </div>
        </div>

    </form>
</@c.page>