package grailstest002

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ReportableTaxPayerController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    PersonService personService
    OrganizationService organizationService
    ReportableTaxPayerService reportableTaxPayerService

    public static String PERSON_PAYER = "Person"
    public static String ENTITY_PAYER = "Entity"

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ReportableTaxPayer.findAllByOwnershipIsNull(params), model:[reportableTaxPayerCount: ReportableTaxPayer.count()]
    }

    def show() {
        println "params:${params}"
        ReportableTaxPayer reportableTaxPayer = ReportableTaxPayer.get(params.getLong("id"))
        respond reportableTaxPayer
    }

    def create() {
        String taxpayerType = params?.taxpayerType
        List<Organization> organizations = null
        List<Person> personList = null
        if(taxpayerType == PERSON_PAYER){
            personList = personService.readAll()
        }else{
            organizations = organizationService.readAll()
        }
        Long parentId = null
        if(params?.parentId){
            parentId = params.getLong("parentId")
        }
        ReportableTaxPayer reportableTaxPayer = new ReportableTaxPayer(params)
        return  [organizations: organizations, personList: personList, parentId: parentId, reportableTaxPayer: reportableTaxPayer, taxpayerType: taxpayerType]
    }



    @Transactional
    def save() {
        println "reportableTaxPayer:"
        ReportableTaxPayer reportableTaxPayer = null
        if(params?.id){
            reportableTaxPayer = ReportableTaxPayer.findById(params?.getLong("id"))
        }else{
            reportableTaxPayer = new ReportableTaxPayer()
        }
        if (params?.id && reportableTaxPayer == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }
        bindData(reportableTaxPayer, params)

        if(!reportableTaxPayer?.id && params?.parentId){
            reportableTaxPayer.reportableTaxPayer = ReportableTaxPayer.findById(params.getLong("parentId"))
        }

        println params.getLong("organizationId")
        println params.getLong("personId")
        if(params?.organizationId){
            reportableTaxPayer?.organization = organizationService.read(params.getLong("organizationId"))
        }
        if(params?.personId){
            reportableTaxPayer?.person = personService.read(params.getLong("personId"))
        }

        println "reportableTaxPayer::${reportableTaxPayer?.dump()}"
        if (!reportableTaxPayer?.validate() && reportableTaxPayer.hasErrors()) {
            transactionStatus.setRollbackOnly()
            String taxpayerType = params?.taxpayerType
            List<Organization> organizations = null
            List<Person> personList = null
            if(taxpayerType == PERSON_PAYER){
                personList = personService.readAll()
            }else{
                organizations = organizationService.readAll()
            }
            render(view: "create", model: [organizations: organizations, personList: personList,
                                           parentId: params?.parentId, reportableTaxPayer: reportableTaxPayer,
                                           taxpayerType: taxpayerType])
            return
        }

        reportableTaxPayer.save flush:true

        request.withFormat {

            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'reportableTaxPayer.label', default: 'ReportableTaxPayer'), reportableTaxPayer.id])
                redirect reportableTaxPayer
            }
            '*' { respond reportableTaxPayer, [status: CREATED] }
        }
    }


    def edit() {
        ReportableTaxPayer reportableTaxPayer = ReportableTaxPayer.get(params.getLong("id"))
        if (reportableTaxPayer == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }
        String taxpayerType = reportableTaxPayer?.organization ? ENTITY_PAYER : PERSON_PAYER
        List<Organization> organizations = null
        List<Person> personList = null
        if(taxpayerType == PERSON_PAYER){
            personList = personService.readAll()
        }else{
            organizations = organizationService.readAll()
        }
//        Long parentId = null
//        if(params?.parentId){
//            parentId = params.getLong("parentId")
//        }
        render view: "create", model: [organizations: organizations, personList: personList, reportableTaxPayer: reportableTaxPayer, taxpayerType: taxpayerType]
    }

    def produceXml(){
        ReportableTaxPayer reportableTaxPayer = ReportableTaxPayer.get(params.getLong("id"))
        if (reportableTaxPayer == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }
        File xmlfile = reportableTaxPayerService.produceXml(params?.getLong("id"))
        response.setContentType("text/xml") // or or image/JPEG or text/xml or whatever type the file is
        response.setHeader("Content-disposition", "attachment;filename=\"${xmlfile.name}\"")
        InputStream contentStream = xmlfile.newInputStream()
        response.outputStream << contentStream
        webRequest.renderView = false
    }

    @Transactional
    def update(ReportableTaxPayer reportableTaxPayer) {
        if (reportableTaxPayer == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (reportableTaxPayer.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond reportableTaxPayer.errors, view:'edit'
            return
        }

        reportableTaxPayer.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'reportableTaxPayer.label', default: 'ReportableTaxPayer'), reportableTaxPayer.id])
                redirect reportableTaxPayer
            }
            '*'{ respond reportableTaxPayer, [status: OK] }
        }
    }

    @Transactional
    def delete(ReportableTaxPayer reportableTaxPayer) {

        if (reportableTaxPayer == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        reportableTaxPayer.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'reportableTaxPayer.label', default: 'ReportableTaxPayer'), reportableTaxPayer.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'reportableTaxPayer.label', default: 'ReportableTaxPayer'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
