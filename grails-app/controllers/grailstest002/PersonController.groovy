package grailstest002

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PersonController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    PersonService personService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Person.list(params), model:[personCount: Person.count()]
    }

    def show(Person person) {
        respond person
    }

    def create() {
        respond new Person(params)
    }

    def addIns(){
        Integer insIndex = params.getInt("insIndex")
        render(template: "ins", model: [map: [key: '', value: ''], size: 0, index: insIndex])
    }

    @Transactional
    def save(Person person) {
        if (person == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (person.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond person.errors, view:'create'
            return
        }
        List insIndexes = params.getList("insIndexes")
        println "insIndexes::${insIndexes}"
        Map<String, String> tins = [:]
        if(insIndexes){
            insIndexes.each{String index ->
                String inKey = params["ins${index}"]
                String inIssuedBy = params["inIssuedBy${index}"]
                println "key:${inKey}, inIssuedBy:${inIssuedBy}, index:${index}"
                if(inKey){
                    tins[inKey] = inIssuedBy
                }
            }
        }
        person.tins = tins
        List<String> addresses = null
        if(params?.address1 || params?.address2 || params?.address3 || params?.address4){
            addresses = []
            if(params?.address1){
                addresses << params?.address1
            }
            if(params?.address2){
                addresses << params?.address2
            }
            if(params?.address3){
                addresses << params?.address3
            }
            if(params?.address4){
                addresses << params?.address4
            }
        }
        person?.addresses = addresses

        person.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'person.label', default: 'Person'), person.id])
                redirect person
            }
            '*' { respond person, [status: CREATED] }
        }
    }

    def edit() {
        respond personService.read(params.getLong("id")), view: "create"
    }

    @Transactional
    def update(Person person) {
        if (person == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (person.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond person.errors, view:'edit'
            return
        }

        person.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'person.label', default: 'Person'), person.id])
                redirect person
            }
            '*'{ respond person, [status: OK] }
        }
    }

    @Transactional
    def delete(Person person) {

        if (person == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        person.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'person.label', default: 'Person'), person.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
