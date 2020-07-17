<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'reportableTaxPayer.label', default: 'ReportableTaxPayer')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-reportableTaxPayer" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                         default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-reportableTaxPayer" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list reportableTaxPayer">

        <g:if test="${this.reportableTaxPayer?.organization}">
            <li class="fieldcontain">
                <span id="organization-label" class="property-label">Organization</span>

                <div class="property-value" aria-labelledby="organization-label">
                    <g:link controller="organization" action="show" id="${this.reportableTaxPayer?.organization?.id}">
                        ${this.reportableTaxPayer?.organization?.name}
                    </g:link>
                </div>
            </li>
        </g:if>

        <g:if test="${this.reportableTaxPayer?.person}">
            <li class="fieldcontain">
                <span id="person-label" class="property-label">Person</span>

                <div class="property-value" aria-labelledby="person-label">
                    <g:link controller="person" action="show" id="${this.reportableTaxPayer?.person?.id}">
                        ${this.reportableTaxPayer?.person?.name}
                    </g:link>
                </div>
            </li>
        </g:if>

        <li class="fieldcontain">
            <span id="ownership-label" class="property-label">Ownership</span>

            <div class="property-value" aria-labelledby="ownership-label">
                ${this.reportableTaxPayer?.ownership}
            </div>
        </li>

        <li class="fieldcontain">
            <span id="investAmount-label" class="property-label">Invest Amount</span>

            <div class="property-value" aria-labelledby="investAmount-label">
                ${this.reportableTaxPayer?.currCode} &nbsp; ${this.reportableTaxPayer?.investAmount}
            </div>
        </li>

        <li class="fieldcontain">
            <span id="otherInfo-label" class="property-label">Other Info</span>

            <div class="property-value" aria-labelledby="otherInfo-label">
                ${this.reportableTaxPayer?.otherInfo}
            </div>
        </li>

        <li class="fieldcontain">
            <span id="language-label" class="property-label">Language</span>

            <div class="property-value" aria-labelledby="language-label">
                ${this.reportableTaxPayer?.language}

            </div>
        </li>

        <g:if test="${!this?.reportableTaxPayer?.isTopLevel}">
            <li class="fieldcontain">
                <span id="reportableTaxPayer-label" class="property-label">Parent</span>

                <div class="property-value" aria-labelledby="reportableTaxPayer-label">
                    <g:link controller="reportableTaxPayer" action="show" id="${reportableTaxPayer?.reportableTaxPayer?.id}">
                        ${reportableTaxPayer?.reportableTaxPayer?.organization ? reportableTaxPayer?.reportableTaxPayer?.organization?.name : reportableTaxPayer?.reportableTaxPayer?.person?.name}
                    </g:link>
                </div>
            </li>
        </g:if>

        <li class="fieldcontain">
            <div class="property-value" aria-labelledby="reportableTaxPayer-label">
            <g:link controller="reportableTaxPayer" action="create"
                    params="[taxpayerType: 'Person', parentId: reportableTaxPayer?.id]">
                Add Person As Child to This Level
            </g:link>
            </div>
        </li>
        <li class="fieldcontain">
            <div class="property-value" aria-labelledby="reportableTaxPayer-label">
            <g:link controller="reportableTaxPayer" action="create"
                    params="[taxpayerType: 'Entity', parentId: reportableTaxPayer?.id]">
                Add Entity As Child This Level
            </g:link>
            </div>
        </li>
        <g:if test="${this?.reportableTaxPayer?.chileRTP}">
            <li class="fieldcontain">
                <span id="chileRTP-label" class="property-label">Chile RTP</span>

                <div class="property-value" aria-labelledby="chileRTP-label">
                    <g:render template="list" model="[reportableTaxPayerList: this?.reportableTaxPayer?.chileRTP, isChildRecords: true]"/>
                </div>
            </li>
        </g:if>

    </ol>
    <g:form resource="${this.reportableTaxPayer}" method="DELETE">
        <fieldset class="buttons">
            <g:link class="edit" action="edit" resource="${this.reportableTaxPayer}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <input class="delete" type="submit"
                   value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                   onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
