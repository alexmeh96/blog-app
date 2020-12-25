<#macro postForm path isCreate>
    <form action="${path}" method="post" class="needs-validation" novalidate>
        <div class="mb-3">
            <label for="exampleInputEmail1" class="form-label">Название</label>
            <input type="text" class="form-control" id="exampleInputEmail1" name="name"
                   <#if !isCreate>value="${post.name}"</#if>
                   required placeholder="назваание">
            <div class="invalid-feedback">
                Поле не должно быть пустым
            </div>
        </div>

        <div class="mb-3">
            <div class="form-floating">
            <textarea name="text" required class="form-control" placeholder="Контент" id="floatingTextarea2"
                      style="height: 100px">
                <#if !isCreate>"${post.text}"</#if>
            </textarea>
                <label for="floatingTextarea2">Контент</label>
                <div class="invalid-feedback">
                    Поле не должно быть пустым
                </div>
            </div>
        </div>

        <input type="hidden" name="_csrf" value="${_csrf.token}"/>

        <#if isCreate>
            <button type="submit" class="btn btn-primary">Создать</button>
        <#else >
            <input type="hidden" name="postId" value="${post.id}"/>
            <button type="submit" class="btn btn-primary">Изменить</button>
        </#if>
    </form>
</#macro>