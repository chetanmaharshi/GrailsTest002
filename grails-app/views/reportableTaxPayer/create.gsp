<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'reportableTaxPayer.label', default: 'ReportableTaxPayer')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<a href="#create-reportableTaxPayer" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                           default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="create-reportableTaxPayer" class="content scaffold-create" role="main">
    <h1><g:message code="default.create.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.reportableTaxPayer}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.reportableTaxPayer}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form action="save">
        <fieldset class="form">

            <g:hiddenField name="id" value="${reportableTaxPayer?.id}"/>
            <g:hiddenField name="parentId" value="${parentId}"/>
            <g:hiddenField name="taxpayerType" value="${taxpayerType}"/>
            <div class="fieldcontain required">
                <g:if test="${organizations}">
                    <label for="organizationId">
                        Entity
                    </label>
                    <g:select name="organizationId" from="${organizations}" optionKey="id" optionValue="name"/>
                </g:if>
                <g:if test="${personList}">
                    <label for="personId">
                        Tax Payer
                    </label>
                    <g:select name="personId" from="${personList}" optionKey="id" optionValue="name"/>
                </g:if>
            </div>

            %{--<div class="fieldcontain required">
                <label for="taxPayerId">Tax Payer Id
                    <span class="required-indicator">*</span>
                </label><input type="number" name="taxPayerId" value="" required="" id="taxPayerId">
            </div>--}%

            <div class="fieldcontain required">
                <label for="ownership">
                    Ownership
                </label>
            <input type="number decimal" name="ownership" value="${this?.reportableTaxPayer?.ownership}" id="ownership">
            </div>

            <div class="fieldcontain">
                <label for="investAmount">Invest Amount</label>
                <input type="number decimal" name="investAmount" value="${this?.reportableTaxPayer?.investAmount}" id="investAmount">
            </div>

            <div class="fieldcontain">
                <label for="otherInfo">Other Info</label><input type="text" name="otherInfo" value="${this?.reportableTaxPayer?.otherInfo}" id="otherInfo">
            </div>

            <div class="fieldcontain">
                <label for="language">Language</label><input type="text" name="language" value="${this?.reportableTaxPayer?.language}" id="language">
            </div>

            %{--<div class="fieldcontain">
                <label for="chileRTP">Chile RTP</label>
            </div>--}%
        </fieldset>
        <fieldset class="buttons">
            <g:submitButton name="create" class="save"
                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
