package grailstest002

class ReportableTaxPayer {

    static transients = ['isTopLevel']

    static mapWith = "mongo"

    static belongsTo = [ReportableTaxPayer]

    ReportableTaxPayer reportableTaxPayer

    Organization organization
    Person person

    BigDecimal ownership

    BigDecimal investAmount

    String currCode = "USD"

    String otherInfo

    String language

    List<ReportableTaxPayer> chileRTP

    static constraints = {
        organization(nullable: true, validator: {val, obj ->
            println "val:${val}"
            println "!obj?.person:${obj?.person}"
            if(!val && !obj?.person){
                return "select.person.or.entity"
            }
        })
        person(nullable: true)
        ownership(nullable: true, scale: 0)
        investAmount(nullable: true, scale: 0)
        currCode(nullable: true, inList: Currency.getAvailableCurrencies()?.currencyCode)
        otherInfo(nullable: true)
        language(nullable: true)
    }

    Boolean getIsTopLevel(){
        if(this.ownership == null){
            return true
        }
        return false
    }
}
