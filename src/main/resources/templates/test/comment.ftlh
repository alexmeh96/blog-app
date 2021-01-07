<#import "../part/common.ftlh" as c>

<style>
    html {
        font-size: 16px;
    }
    .media-body .author {
        display: block;
        font-size: 1rem;
        color: #000;
        font-weight: 700;
    }
    .media-body .metadata {
        display: block;
        color: #777;
        font-size: .8125rem;
    }
    .media-text {
        margin-bottom: 0.25rem;
    }
    .title-comments {
        font-size: 1.4rem;
        font-weight: bold;
        line-height: 1.5rem;
        color: rgba(0,0,0,.87);
        margin-bottom: 1rem;
        padding-bottom: .25rem;
        border-bottom: 1px solid rgba(34,36,38,.15);
    }
    .media-left img {
        width: 50px;
    }
</style>
<@c.page>

    <div class="container">
        <h1 class="h3 text-center page-header">Коментарии к посту</h1>
    </div>
    <div class="container">
        <div class="comments">
            <h3 class="title-comments">Комментарии (6)</h3>
            <ul class="media-list">
                <!-- Комментарий (уровень 1) -->
                <li class="media">
                    <div class="media-left">
                        <a href="#">
                            <img class="media-object" src="/examples/images/avatar1.jpg" alt="...">
                        </a>
                    </div>
                    <div class="media-body">
                        <div class="media-heading">
                            <div class="author">Дима</div>
                            <div class="metadata">
                                <span class="date">16 ноября 2015, 13:43</span>
                            </div>
                        </div>
                        <div class="media-text text-justify">Lorem ipsum dolor sit amet. Blanditiis praesentium voluptatum deleniti atque. Autem vel illum, qui blanditiis praesentium voluptatum deleniti atque corrupti. Dolor repellendus cum soluta nobis. Corporis suscipit laboriosam, nisi ut enim. Debitis aut perferendis doloribus asperiores repellat. sint, obcaecati cupiditate non numquam eius. Itaque earum rerum facilis. Similique sunt in ea commodi. Dolor repellendus numquam eius modi. Quam nihil molestiae consequatur, vel illum, qui ratione voluptatem accusantium doloremque.</div>

                        <hr>
                    </div>
            </ul>
        </div>

    </div>
</@c.page>