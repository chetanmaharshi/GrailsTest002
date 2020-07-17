package grailstest002

import grails.transaction.Transactional

@Transactional
class PersonService {

    List<Person> readAll(){
        return Person.findAll()
    }

    Person read(Long id){
        return Person.findById(id)
    }
}
