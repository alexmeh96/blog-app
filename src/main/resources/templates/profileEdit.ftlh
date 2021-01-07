<#import "part/common.ftlh" as c>
<#import "part/postForm.ftlh" as p>
<#include "part/security.ftlh">

<@c.page>
    <div class="emp-board">
        <form action="/profile/update" method="post" class="needs-validation" novalidate>
            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label">Email</label>
                <input type="email" class="form-control" id="exampleInputEmail1" name="email"
                       value="${profile.email}"
                       placeholder="email">
            </div>

            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label">Номер телефона</label>
                <input type="text" class="form-control" id="exampleInputEmail1" name="phoneNumber"
                       required placeholder="phoneNumber" value="${profile.phoneNumber}">
            </div>

            <input type="hidden" name="_csrf" value="${_csrf.token}"/>


            <input type="hidden" name="profileId" value="${profile.id}"/>
            <button type="submit" class="btn btn-primary">Обновить</button>

        </form>
    </div>
</@c.page>