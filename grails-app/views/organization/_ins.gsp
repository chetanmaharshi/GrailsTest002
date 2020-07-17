<div class="fieldcontain index${index}">
    <g:hiddenField name="insIndexes" value="${index}"/>
    <label for="ins">Ins</label>
    <g:textField name="ins${index}" value="${map.key}"/>
&nbsp;Issued By
    <g:select name="inIssuedBy${index}" id="inIssuedBy${index}"
              from="${Locale.getISOCountries()?.toList()}" value="${map.value}"/>
    <g:if test="${index == 0}">
        <span class="buttons" style="cursor: pointer" onclick="addNewIns()">Add</span>
    </g:if>
    <g:if test="${index !=0}">
        <span class="buttons" style="cursor: pointer;color: red;" onclick="removeIns('index${index}')">Remove</span>
    </g:if>
    <script>
        insIndex = insIndex + 1
    </script>
</div>
