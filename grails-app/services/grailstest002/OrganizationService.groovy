package grailstest002

import grails.transaction.Transactional

@Transactional
class OrganizationService {

    List<Organization> readAll(){
        return Organization.findAll()
    }

    Organization read(Long id){
        return Organization.findById(id)
    }
}
