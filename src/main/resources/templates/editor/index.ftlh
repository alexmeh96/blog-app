<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/froala-editor@3.1.0/css/froala_editor.pkgd.min.css" rel="stylesheet"
          type="text/css"/>

</head>
<body>

<div id="example">

    <div>
        <form action="/image/save" method="post" enctype="multipart/form-data">
            <textarea name="editor_content" id="editor">

            </textarea>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button type="submit">Submit</button>
        </form>
    </div>

<#--    <div class="fr-view">-->
<#--        Here comes the HTML edited with the Froala rich text editor.-->
<#--    </div>-->
</div>

<script type="text/javascript"
        src="https://cdn.jsdelivr.net/npm/froala-editor@3.1.0/js/froala_editor.pkgd.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
        src="https://code.jquery.com/jquery-3.5.1.js"
        integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
        crossorigin="anonymous"></script>

<script>
    // new FroalaEditor('#example')

    // new FroalaEditor('#example', {
    //     // Set the image upload URL.
    //     imageUploadURL: '/image', // 업로드 처리 end point
    //     imageUploadParam: 'file', // 파일 파라메터명
    //     imageUploadMethod: 'POST',
    //     imageAllowedTypes: ['jpeg', 'jpg', 'png'],
    //     // imageMaxSize: 2 * 1024 * 1024 // 최대 이미지 사이즈 : 2메가
    //
    // })

    <#--var editor = new FroalaEditor("#editor", {-->
    <#--    imageUploadURL: '/image',-->
    <#--    imageUploadParam: 'file',-->
    <#--    imageUploadMethod: 'post',-->
    <#--    imageManagerLoadURL: '/image',-->
    <#--    imageMaxSize: 2 * 1024 * 1024 * 1024,-->
    <#--    imageUploadParams: {-->
    <#--        froala: true,-->
    <#--        _csrf: "${_csrf.token}"-->
    <#--    }-->
    <#--});-->

    (function() {
        new FroalaEditor('#editor',{
            imageUploadURL: '/editor/image',
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
                        url: "/image/delete" ,
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

</body>
</html>