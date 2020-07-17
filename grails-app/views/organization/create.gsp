<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'organization.label', default: 'Organization')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="application/javascript">
        var insIndex = 0;
        function addNewIns(){
            var url = "${g.createLink(controller: 'organization', action: 'addIns')}?insIndex="+insIndex;
            $.ajax({url: url, success: function(result){
                    $(".insList").append(result);
                }});

        }
        function removeIns(removeElement){
            $("."+removeElement).remove()
        }
    </script>


</head>

<body>
<a href="#create-organization" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                     default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="create-organization" class="content scaffold-create" role="main">
    <h1><g:message code="default.create.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.organization}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.organization}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form action="save">
        <fieldset class="form">
            <g:if test="${this.organization?.id}">
                <g:hiddenField name="id" value="${this.organization?.id}"/>
            </g:if>
            <div class="fieldcontain required">
                <label for="tin">Tin
                    <span class="required-indicator">*</span>
                </label>
                <input type="text" name="tin" value="${this.organization.tin}" required="" id="tin">
                &nbsp;Issued By <span class="required-indicator">*</span>
                <g:select name="issuedBy" id="issuedBy" class=" required"
                          from="${Locale.getISOCountries()?.toList()}" value="${this.organization.issuedBy}"/>

            </div>

            <div class="fieldcontain required">
                <label for="name">Name
                    <span class="required-indicator">*</span>
                </label><input type="text" name="name" value="${this.organization.name}" required="" id="name">
            </div>
            <g:each in="[1, 2, 3, 4]" var="index">
            <div class="fieldcontain">
                <label for="address${index}">Address${index}</label>
                <textarea name="address${index}" id="address${index}" rows="2" style="height: auto"><g:if test="${(index) <= this?.organization?.addresses?.size()}">${this.organization.addresses[(index-1)]}</g:if></textarea>
            </div>
            </g:each>
%{--

            <div class="fieldcontain">
                <label for="address1">Address2</label>
                <textarea name="address1" id="address2" rows="2" style="height: auto"></textarea>
            </div>

            <div class="fieldcontain">
                <label for="address3">Address3</label>
                <textarea name="address3" id="address3" rows="2" style="height: auto"></textarea>
            </div>

            <div class="fieldcontain">
                <label for="address4">Address3</label>
                <textarea name="address4" id="address4" rows="2" style="height: auto"></textarea>
            </div>
--}%



            <div class="fieldcontain">
                <label for="language">Language</label>
                <input type="text" name="language" value="${this.organization.language}" id="language">
            </div>

            <div class="insList">
                <g:if test="${this.organization?.ins}">
                    <g:each in="${this.organization?.ins}" var="map" status="index">
                        <g:render template="ins" model="[map: map, index: index, size:this.organization?.insCount]"/>
                    </g:each>
                </g:if>
                <g:else>
                    <g:render template="ins" model="[map: [key: '', value: ''], size: 0, index: 0]"/>
                </g:else>
            </div>
        </fieldset>
        <fieldset class="buttons">
            <g:submitButton name="create" class="save"
                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
