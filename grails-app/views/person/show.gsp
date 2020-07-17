<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-person" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-person" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <ol class="property-list person">

                <li class="fieldcontain">
                    <span id="firstName-label" class="property-label">First Name</span>
                    <div class="property-value" aria-labelledby="firstName-label">${this.person.firstName}</div>
                </li>

                <li class="fieldcontain">
                    <span id="lastName-label" class="property-label">Last Name</span>
                    <div class="property-value" aria-labelledby="lastName-label">${this.person.lastName}</div>
                </li>

                <li class="fieldcontain">
                    <span id="birthDate-label" class="property-label">Birth Date</span>
                    <div class="property-value" aria-labelledby="birthDate-label">${this.person.birthDate?.format("MM/dd/yyyy")}</div>
                </li>

                <li class="fieldcontain">
                    <span id="addresses-label" class="property-label">Addresses</span>
                    <g:each in="${this.person.addresses}" var="address">
                        <div class="property-value" aria-labelledby="addresses-label">
                            ${address}
                        </div>
                    </g:each>
                </li>

                <li class="fieldcontain">
                    <span id="tins-label" class="property-label">Tins</span>
                    <g:each in="${this.person.tins}" var="tin">
                        <div class="property-value" aria-labelledby="ins-label">
                            ${tin.key} Issued By ${tin.value}
                        </div>
                    </g:each>
                </li>

            </ol>
            <g:form resource="${this.person}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.person}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
