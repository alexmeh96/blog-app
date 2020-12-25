<#macro login path isRegisterForm>
    <form action="${path}" method="post" class="needs-validation" novalidate>
        <div class="mb-3">
            <label for="exampleInputEmail1" class="form-label">Имя пользователя</label>
            <input type="text" class="form-control" id="exampleInputEmail1" name="username"
                   required placeholder="username">
            <div class="invalid-feedback">
                Поле не должно быть пустым
            </div>
            <#if usernameError??>
                <div >
                    ${usernameError}
                </div>
            </#if>
        </div>
        <div class="mb-3">
            <label for="exampleInputPassword1" class="form-label">Пароль</label>
            <input type="password" class="form-control" id="exampleInputPassword1" name="password" required placeholder="пароль">
            <div class="invalid-feedback">
                Поле не должно быть пустым
            </div>
            <#if passwordError??>
                <div>
                    ${passwordError}
                </div>
            </#if>
        </div>
        <#if isRegisterForm>
            <div class="mb-3">
                <label for="exampleInputPassword2" class="form-label">Повторите пароль</label>
                <input type="password" class="form-control" id="exampleInputPassword2" name="password2" required placeholder="повторите пароль">
                <div class="invalid-feedback">
                    Поле не должно быть пустым
                </div>
                <#if password2Error??>
                    <div class="feedback">
                        ${password2Error}
                    </div>
                </#if>
            </div>
        </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <#if !isRegisterForm>
            <div class="mb-3"><a href="/registration">Создать пользователя</a></div>
        </#if>
        <div>
            <button type="submit" class="btn btn-primary"><#if isRegisterForm>Создать<#else>Войти</#if></button>
        </div>

    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">Выйти</button>
    </form>
</#macro>