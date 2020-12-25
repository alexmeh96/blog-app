<#macro mes>
    <#if message??>
        <div class="alert alert-success" role="alert">
            ${message}
        </div>
    <#elseif messageError??>
        <div class="alert alert-danger" role="alert">
            ${messageError}
        </div>
    </#if>

</#macro>