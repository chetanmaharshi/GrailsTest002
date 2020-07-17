<table>
    <thead>
    <tr>

        <th>ID</th>
        <g:if test="${isChildRecords}">
            <th>Ownership</th>
        </g:if>
        <th>Invest Amount</th>
        <th>Other Info</th>
        <th>Language</th>
        <th>Child Records</th>
        <th>&nbsp;</th>
        <g:if test="${!isChildRecords}">
            <th>&nbsp;</th>
        </g:if>
    </tr>
    </thead>
    <tbody>

    <g:each in="${reportableTaxPayerList}" var="reportableTaxPayer">
        <tr>

            <td>
                <g:link controller="reportableTaxPayer" action="show" id="${reportableTaxPayer?.id}">
                    ${reportableTaxPayer?.organization ? reportableTaxPayer?.organization?.name : reportableTaxPayer?.person?.name}
                </g:link>
            </td>
            <g:if test="${isChildRecords}">
                <td>${reportableTaxPayer?.ownership}</td>
            </g:if>
            <td>${reportableTaxPayer?.currCode}&nbsp;${reportableTaxPayer?.investAmount}</td>
            <td>${reportableTaxPayer?.otherInfo}</td>
            <td>${reportableTaxPayer?.language}</td>
            <td>${reportableTaxPayer?.chileRTP?.size()}</td>
            <td>
                <g:link controller="reportableTaxPayer" action="create"
                        params="[taxpayerType: 'Person', parentId: reportableTaxPayer?.id]">
                    Add Person As Child
                </g:link>
                &nbsp;&nbsp;
                <g:link controller="reportableTaxPayer" action="create"
                        params="[taxpayerType: 'Entity', parentId: reportableTaxPayer?.id]">
                    Add Entity As Child
                </g:link>
            </td>
            <g:if test="${!isChildRecords}">
                <td>
                    <g:link controller="reportableTaxPayer" action="produceXml" id="${reportableTaxPayer?.id}">
                        Produce XML
                    </g:link>
                </td>
            </g:if>
        </tr>
    </g:each>

    </tbody>
</table>