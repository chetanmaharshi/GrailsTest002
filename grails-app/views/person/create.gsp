<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
    <script type="application/javascript">
        var insIndex = 0;
        function addNewIns(){
            var url = "${g.createLink(controller: 'person', action: 'addIns')}?insIndex="+insIndex;
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
<a href="#create-person" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                               default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="create-person" class="content scaffold-create" role="main">
    <h1><g:message code="default.create.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.person}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.person}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form action="save">
        <g:hiddenField name="id" value="${this.person?.id}"/>
        <fieldset class="form">
            <div class="fieldcontain required">
                <label for="firstName">First Name
                    <span class="required-indicator">*</span>
                </label><input type="text" name="firstName" value="${this.person.firstName}" required="" id="firstName">
            </div>

            <div class="fieldcontain required">
                <label for="lastName">Last Name
                    <span class="required-indicator">*</span>
                </label>
                <input type="text" name="lastName" value="${this.person.lastName}" required="" id="lastName">
            </div>

            <div class="fieldcontain">
                <label for="birthDate">Birth Date</label>

                <g:datePicker name="birthDate" value="${this.person.birthDate}" precision="day"/>

            </div>

            <g:each in="[1, 2, 3, 4]" var="index">
                <div class="fieldcontain">
                    <label for="address${index}">Address${index}</label>
                    <textarea name="address${index}" id="address${index}" rows="2" style="height: auto"><g:if test="${(index) <= this?.person?.addresses?.size()}">${this.person.addresses[(index-1)]}</g:if></textarea>
                </div>
            </g:each>


            <div class="insList">
                <g:if test="${this.person?.tins}">
                    <g:each in="${this.person?.tins}" var="map" status="index">
                        <g:render template="ins" model="[map: map, index: index, size:this.person?.insCount]"/>
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
