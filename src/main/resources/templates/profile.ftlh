<#import "part/common.ftlh" as c>
<#import "part/postForm.ftlh" as p>
<#include "part/security.ftlh">

<@c.page>
    <style>

        .emp-profile {
            padding: 3%;
            margin-top: 3%;
            margin-bottom: 3%;
            border-radius: 0.5rem;
            background: #fff;
        }

        .profile-img {
            text-align: center;
        }

        .profile-img img {
            width: 70%;
            /*height: 100%;*/
        }

        .profile-img .file {
            position: relative;
            overflow: hidden;
            margin-top: -20%;
            width: 70%;
            border: none;
            border-radius: 0;
            font-size: 15px;
            background: #212529b8;
        }

        .profile-img .file input {
            position: absolute;
            opacity: 0;
            right: 0;
            top: 0;
        }

        .profile-head h5 {
            color: #333;
        }

        .profile-head h6 {
            color: #0062cc;
        }

        .profile-edit-btn {
            border: none;
            border-radius: 1.5rem;
            width: 50%;
            padding: 2%;
            font-weight: 600;
            color: #6c757d;
            cursor: pointer;
        }

        .proile-rating {
            font-size: 12px;
            color: #818182;
            margin-top: 5%;
        }

        .proile-rating span {
            color: #495057;
            font-size: 15px;
            font-weight: 600;
        }

        .profile-head .nav-tabs {
            margin-bottom: 5%;
        }

        .profile-head .nav-tabs .nav-link {
            font-weight: 600;
            border: none;
        }

        .profile-head .nav-tabs .nav-link.active {
            border: none;
            border-bottom: 2px solid #0062cc;
        }

        .profile-work {
            padding: 14%;
            margin-top: -15%;
        }

        .profile-work p {
            font-size: 12px;
            color: #818182;
            font-weight: 600;
            margin-top: 10%;
        }

        .profile-work a {
            text-decoration: none;
            color: #495057;
            font-weight: 600;
            font-size: 14px;
        }

        .profile-work ul {
            list-style: none;
        }

        .profile-tab label {
            font-weight: 600;
        }

        .profile-tab p {
            font-weight: 600;
            color: #0062cc;
        }
    </style>

    <div class="container emp-profile">

        <div class="row">
            <div class="col-md-4">
                <form action="/profile/update/avatar" method="post" enctype="multipart/form-data">
                    <div class="profile-img">
                        <img src="/image/${profile.avatarId}"
                             alt="" id="my_img"/>
                        <div class="file btn btn-lg btn-primary">
                            Change Photo
                            <input type="file" name="file" id="file-selector"/>
                        </div>
                    </div>
                    <p id="status"></p>
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button id="save" type="submit" class="btn btn-primary" hidden>Сохранить</button>
                </form>
            </div>
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-8">
                        <div class="profile-head">
                            <h5>
                                ${profile.author.username}
                            </h5>
                            <h6>
                                Web Developer and Designer
                            </h6>
                        </div>
                    </div>
                    <#if profile.author.id == currentUserId>
                        <div class="col-md-4">
                            <#--                        <input type="submit" class="profile-edit-btn" name="btnAddMore" value="Edit Profile"/>-->
                            <a href="/profile/update">Изменить профиль</a>
                        </div>
                    </#if>
                </div>

                <div class="tab-content profile-tab" id="myTabContent">
                    <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                        <div class="row">
                            <div class="col-md-6">
                                <label>Email</label>
                            </div>
                            <div class="col-md-6">
                                <p>${profile.email}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label>Номер телефона</label>
                            </div>
                            <div class="col-md-6">
                                <p>${profile.phoneNumber}</p>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </div>
        <#if profile.author.id == currentUserId>
            <div class="row">
                <div class="col-md-4">
                    <h3>Мои подписчики</h3>
                    <#if subscribers??>
                        <#list subscribers as subscriber>
                            <p>
                                <a href="/profile/${subscriber.id}">${subscriber.username}</a>
                            </p>
                        </#list>

                    <#else>
                        <p>У вас нет подписчиков</p>
                    </#if>
                </div>
                <div class="col-md-8">

                </div>

            </div>
        <#else >
            <div>
                <a href="/post/${profile.author.id}">Посты пользователя</a>
            </div>

            <#if isSubscribe>
                <p>Вы подписаны на этого пользователя</p>
            <#else >
                <div class="mb-3">
                    <form action="/profile/subscribe" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <input type="hidden" name="userId" value="${profile.author.id}"/>

                        <button type="submit" class="btn btn-primary">Подписаться</button>
                    </form>
                </div>
            </#if>
        </#if>


    </div>

</@c.page>

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

            document.getElementById("save").hidden = false

        });
    }
</script>