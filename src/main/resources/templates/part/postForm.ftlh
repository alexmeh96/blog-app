<#macro postForm path isCreate>

    <form action="${path}" method="post" class="needs-validation" novalidate enctype="multipart/form-data">
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
            <label for="exampleInputEmail12" class="form-label">Описание для превью</label>
            <input type="text" class="form-control" id="exampleInputEmail12" name="describe"
                   <#if !isCreate>value="${post.describe}"</#if>
                   required placeholder="Описание для превью">
            <div class="invalid-feedback">
                Поле не должно быть пустым
            </div>
        </div>

        <div class="mb-3">
            <#if !isCreate>
                <div class="form-check">
                    <input name="changeImage" value="true" class="form-check-input" type="checkbox"  id="flexCheckDefault">
                    <label class="form-check-label" for="flexCheckDefault">
                        Изменить изображение
                    </label>
                </div>
            </#if>
            <label for="formFile" class="form-label">Изображение для превью</label>
            <input name="file" class="form-control" type="file" id="file-selector">
            <div class="mt-1">
                <img <#if !isCreate>src="/image/${post.imagePreviewId}" </#if>
                     width="25%"
                     alt="" id="my_img"/>
            </div>
            <p id="status"></p>
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
        (function () {
            new FroalaEditor('#editor', {
                imageUploadURL: '/editor/image',
                imageUploadParams: {
                    id: 'my_editor',
                    froala: true,
                    _csrf: "${_csrf.token}"
                },

                imageUploadParam: 'file',
                imageManagerLoadURL: '/image',
                imageManagerDeleteURL: "/image/delete",
                imageManagerDeleteMethod: "POST",
                imageManagerDeleteParams: {
                    _csrf: "${_csrf.token}",
                    id: "15",
                },
                events: {
                    // Catch image removal from the editor.
                    'image.beforeRemove': function ($img) {
                        console.log($img.attr('src'))
                    },
                    'image.removed': function ($img) {
                        $.ajax({
                            // Request method.
                            method: "POST",
                            // Request URL.
                            url: "/image/delete/",
                            // Request params.
                            data: {
                                _csrf: "${_csrf.token}",
                                id: $img.attr('src').slice(7),
                            }
                        })
                            .done(function (data) {
                                console.log('image was deleted');
                            })
                            .fail(function (err) {
                                console.log('image delete problem: ' + JSON.stringify(err));
                            })
                    },
                }
            })
        })();
    </script>
    <script>
        const status = document.getElementById('status');
        const output = document.getElementById('my_img');
        if (window.FileList && window.File && window.FileReader) {
            document.getElementById('file-selector').addEventListener('change', event => {
                output.src = '';
                status.textContent = '';
                const file = event.target.files[0];
                if (!file.type) {
                    status.textContent = 'Ошибка: свойство File. type, по-видимому, не поддерживается в этом браузере.';
                    return;
                }
                if (!file.type.match('image.*')) {
                    status.textContent = 'Ошибка: выбранный файл не является изображением.'
                    return;
                }
                const reader = new FileReader();
                reader.addEventListener('load', event => {
                    output.src = event.target.result;
                });
                reader.readAsDataURL(file);

            });
        }
    </script>
</#macro>