package grailstest002

class BootStrap {

    def init = { servletContext ->

        Locale.getISOCountries().each { country ->
            def locale = new Locale("", country)
            // e.g. isoCodesMap = [AND:AD, ARE:AE, AFG:AF, ATG:AG, AIA:AI, ALB:AL, ARM:AM, ANT:AN,....
            println "country::${country?.dump()}"
            println "ISO::${locale.getISO3Country().toUpperCase()}"
        }
        println "Locale.getISOCountries():${Locale.getISOCountries()}"

        Currency.getAvailableCurrencies()?.each{Currency currency ->
            println "Currency::${currency?.dump()}"
        }
    }
    def destroy = {
    }
}
