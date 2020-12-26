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
<#--            <textarea name="text" required class="form-control" placeholder="Контент" id="floatingTextarea2"-->
<#--                      style="height: 100px">-->
<#--                <#if !isCreate>"${post.text}"</#if>-->
                <#--            </textarea>-->

                <textarea name="text" id="editor" placeholder="Контент">
                    <#if !isCreate>"${post.text}"</#if>

                </textarea>
<#--                <label for="editor">Контент</label>-->
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

    <script type="text/javascript"
            src="https://cdn.jsdelivr.net/npm/froala-editor@3.1.0/js/froala_editor.pkgd.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script
            src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
            crossorigin="anonymous"></script>
    <script>
        (function() {
            new FroalaEditor('#editor',{
                imageUploadURL: '/image',
                imageUploadParams: {
                    id: 'my_editor',
                    froala: true,
                    _csrf: "${_csrf.token}"
                },

                imageUploadParam: 'file',
                imageManagerLoadURL: '/image',
                imageManagerDeleteURL: "/delete",
                imageManagerDeleteMethod: "POST",
                imageManagerDeleteParams: {
                    _csrf: "${_csrf.token}",
                    id: "15",
                },
                events : {
                    // Catch image removal from the editor.
                    'image.beforeRemove': function ($img) {
                        console.log($img.attr('src'))
                    },
                    'image.removed': function ($img) {
                        $.ajax({
                            // Request method.
                            method: "POST",
                            // Request URL.
                            url: "/delete/" ,
                            // Request params.
                            data: {
                                _csrf: "${_csrf.token}",
                                id: $img.attr('src').slice(7),
                            }
                        })
                            .done (function (data) {
                                console.log ('image was deleted');
                            })
                            .fail (function (err) {
                                console.log ('image delete problem: ' + JSON.stringify(err));
                            })
                    },

                }
            })
        })();
    </script>
</#macro>