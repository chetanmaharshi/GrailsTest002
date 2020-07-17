<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'organization.label', default: 'Organization')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-organization" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-organization" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <ol class="property-list organization">

                <li class="fieldcontain">
                    <span id="tin-label" class="property-label">Tin</span>
                    <div class="property-value" aria-labelledby="tin-label">${this.organization.tin}</div>
                </li>

                <li class="fieldcontain">
                    <span id="issuedBy-label" class="property-label">Issued By</span>
                    <div class="property-value" aria-labelledby="issuedBy-label">${this.organization.issuedBy}</div>
                </li>

                <li class="fieldcontain">
                    <span id="name-label" class="property-label">Name</span>
                    <div class="property-value" aria-labelledby="name-label">${this.organization.name}</div>
                </li>

                <li class="fieldcontain">
                    <span id="language-label" class="property-label">Language</span>
                    <div class="property-value" aria-labelledby="language-label">${this.organization.language}</div>
                </li>

                <li class="fieldcontain">
                    <span id="addresses-label" class="property-label">Addresses</span>
                    <g:each in="${this.organization.addresses}" var="address">
                        <div class="property-value" aria-labelledby="addresses-label">
                            ${address}
                        </div>
                    </g:each>
                </li>

                <li class="fieldcontain">
                    <span id="ins-label" class="property-label">Ins</span>
                    <g:each in="${this.organization.ins}" var="ins">
                        <div class="property-value" aria-labelledby="ins-label">
                            ${ins.key} Issued By ${ins.value}
                        </div>
                    </g:each>
                </li>

            </ol>
            <g:form resource="${this.organization}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.organization}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
