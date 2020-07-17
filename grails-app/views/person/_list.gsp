<table>
    <thead>
    <tr>
        <g:sortableColumn property="firstName" title="First Name"/>
        <g:sortableColumn property="lastName" title="Last Name"/>
        <g:sortableColumn property="birthDate" title="Birth Date"/>
        <th>Addresses</th>
        <th>Tin(s)</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${persons}" var="person" status="i">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
            <td>
                <g:link method="GET" controller="person" action="show" id="${person?.id}">
                    ${person?.firstName}
                </g:link>
            </td>
            <td>
                ${person?.lastName}
            </td>
            <td>
                ${person?.birthDate?.format("MM/dd/yyyy")}
            </td>
            <td>
                <g:each in="${person.addresses}" var="address">
                    <div class="property-value" aria-labelledby="addresses-label">
                        ${address}
                    </div>
                </g:each>
            </td>
            <td>
                <g:each in="${person.tins}" var="tin">
                    <div class="property-value" aria-labelledby="ins-label">
                        ${tin.key} Issued By ${tin.value}
                    </div>
                </g:each>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>