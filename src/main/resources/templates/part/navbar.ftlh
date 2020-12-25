<#include "security.ftlh">
<#import "login.ftlh" as l>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">YourWork</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/">Главная</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="/post/all">Посты</a>
                </li>
                <#if user??>
                    <li class="nav-item">
                        <a class="nav-link" href="/post/create">Создать пост</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/post/${currentUserId}">Мои посты</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/post/subscribe">Подписки</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/profile/${currentUserId}">Профиль</a>
                    </li>
                </#if>
                <#if isAdmin>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin">Admin</a>
                    </li>
                </#if>
            </ul>

            <#if user??>
                <div class="navbar-text me-3">
                    ${name}
                </div>
                <@l.logout />
            <#else>
                <a href="/login" class="btn btn-primary">Вход</a>
            </#if>

        </div>
    </div>
</nav>