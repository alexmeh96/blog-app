<#import "part/common.ftlh" as c>


<@c.page>
    <form action="/image" method="post" enctype="multipart/form-data">
        image: <input type="file" name="file">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>

        <input type="submit" value="load file">
    </form>
</@c.page>