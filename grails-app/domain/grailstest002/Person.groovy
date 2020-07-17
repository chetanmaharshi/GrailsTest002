package grailstest002

class Person {

    static transients = ['name']

    static mapWith = "mongo"

    Map<String, String> tins

    String firstName
    String lastName

    List addresses

    Date birthDate

    static constraints = {
//        tin(nullable: false)
//        issuedBy(nullable: false, inList: Locale.getISOCountries()?.toList())
        firstName(nullable: false)
        lastName(nullable: false)
        birthDate(nullable: true)
    }

    String getName(){
        return "${firstName} ${lastName}"
    }
}
