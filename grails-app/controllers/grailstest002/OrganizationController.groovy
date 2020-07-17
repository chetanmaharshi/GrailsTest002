package grailstest002

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OrganizationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    OrganizationService organizationService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Organization.list(params), model:[organizationCount: Organization.count()]
    }

    def show(Long id) {
        Organization organization = organizationService.read(id)
        respond organization
    }

    def create() {
        respond new Organization(params)
    }

    def addIns(){
        Integer insIndex = params.getInt("insIndex")
        render(template: "ins", model: [map: [key: '', value: ''], size: 0, index: insIndex])
    }

    @Transactional
    def save(Organization organization) {
        println "params:${params}"
        if (organization == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (organization.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond organization.errors, view:'create'
            return
        }

        List insIndexes = params.getList("insIndexes")
        println "insIndexes::${insIndexes}"
        Map<String, String> ins = [:]
        if(insIndexes){
            insIndexes.each{String index ->
                String inKey = params["ins${index}"]
                String inIssuedBy = params["inIssuedBy${index}"]
                println "key:${inKey}, inIssuedBy:${inIssuedBy}, index:${index}"
                if(inKey){
                    ins[inKey] = inIssuedBy
                }
            }
        }
        organization.ins = ins
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
        organization?.addresses = addresses
        organization.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'organization.label', default: 'Organization'), organization.id])
                redirect organization
            }
            '*' { respond organization, [status: CREATED] }
        }
    }

    def edit(Long id) {
        Organization organization = organizationService.read(id)
        respond organization, view:'create'
    }

    @Transactional
    def update(Organization organization) {
        if (organization == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (organization.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond organization.errors, view:'edit'
            return
        }

        organization.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'organization.label', default: 'Organization'), organization.id])
                redirect organization
            }
            '*'{ respond organization, [status: OK] }
        }
    }

    @Transactional
    def delete(Organization organization) {

        if (organization == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        organization.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'organization.label', default: 'Organization'), organization.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'organization.label', default: 'Organization'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
