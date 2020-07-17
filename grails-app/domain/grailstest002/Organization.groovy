package grailstest002

class Organization {

    static transients = ['insCount']

    static mapWith = "mongo"

    String tin

    String issuedBy

    String name

    List addresses

    Map<String, String> ins

    String language

    static constraints = {
        tin(nullable: false)
        issuedBy(nullable: false, inList: Locale.getISOCountries()?.toList())
        name(nullable: false)
//        address(nullable: true)
//        inIssuedBy(nullable: true, inList: Locale.getISOCountries()?.toList())
        language(nullable: true)
    }

    Integer getInsCount(){
        if(this.ins){
            return this.ins.keySet()?.size()
        }
        return 0
    }
}
