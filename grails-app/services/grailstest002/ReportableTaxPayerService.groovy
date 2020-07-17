package grailstest002

import grails.transaction.Transactional
import groovy.xml.MarkupBuilder

@Transactional
class ReportableTaxPayerService {

    ReportableTaxPayer read(Long id){
        return ReportableTaxPayer.get(id)
    }

    def produceXml(Long id) {
        return produceXml(read(id))
    }
    File produceXml(ReportableTaxPayer reportableTaxPayer) {
        File file = new File("GrailsTest.xml")
        def stringWriter = new StringWriter()
        MarkupBuilder reportableTaxPaymentXml = new MarkupBuilder(stringWriter)
        /*reportableTaxPaymentXml?.ID{
            if(reportableTaxPayer?.organization){
                organisation{
                    Name(reportableTaxPayer?.organization?.name)
                    TIN(issuedBy: reportableTaxPayer?.organization?.issuedBy, reportableTaxPayer?.organization?.tin)
                    reportableTaxPayer?.organization?.ins?.each{String key, String value ->
                        IN("issuedBy":value , key)
                    }
                    reportableTaxPayer?.organization?.addresses?.each{
                        Address(it)
                    }
                }
            }
        }
        reportableTaxPaymentXml.InvestAmount("currCode": "${reportableTaxPayer?.currCode}", reportableTaxPayer?.investAmount)
        reportableTaxPaymentXml.OtherInfo(reportableTaxPayer?.otherInfo)
        if(reportableTaxPayer?.chileRTP){
            reportableTaxPaymentXml.ListChilds{
                ChildRTP {
                    reportableTaxPayer?.chileRTP?.each { ReportableTaxPayer childRtpInstance ->

                        produceXml(childRtpInstance)
                    }
                }
            }
        }*/
        reportableTaxPaymentXml.GrailsTest{
            reportableTaxPaymentXml = produceXMLForReportableTaxPaymentNode(reportableTaxPaymentXml, reportableTaxPayer)
        }
        def xml = stringWriter.toString()
        file.write(xml)
        println "###############  \n ${file.getText()}"
        return file
    }

    def produceXMLForReportableTaxPaymentNode(MarkupBuilder reportableTaxPaymentXml, ReportableTaxPayer reportableTaxPayer){
        reportableTaxPaymentXml?.ID{
            if(reportableTaxPayer?.organization){
                organisation{
                    Name(reportableTaxPayer?.organization?.name)
                    TIN(issuedBy: reportableTaxPayer?.organization?.issuedBy, reportableTaxPayer?.organization?.tin)
                    reportableTaxPayer?.organization?.ins?.each{String key, String value ->
                        IN("issuedBy":value , key)
                    }
                    reportableTaxPayer?.organization?.addresses?.each{
                        println "add:${it}"
                        Address(it)
                    }
                }
            }else{
                Individual{
                    reportableTaxPayer?.person?.tins?.each{String key, String value ->
                        TIN("issuedBy":value , key)
                    }
                    Name{
                        FirstName(reportableTaxPayer?.person?.firstName)
                        LastName(reportableTaxPayer?.person?.lastName)
                    }
                    reportableTaxPayer?.person?.addresses?.each{
                        Address(it)
                    }
                }
            }
        }
        if(reportableTaxPayer?.ownership!=null) {
            reportableTaxPaymentXml.Ownership(reportableTaxPayer?.ownership)
        }
        reportableTaxPaymentXml.InvestAmount("currCode": "${reportableTaxPayer?.currCode}", reportableTaxPayer?.investAmount)
        reportableTaxPaymentXml.OtherInfo(reportableTaxPayer?.otherInfo)
        if(reportableTaxPayer?.chileRTP){
            reportableTaxPaymentXml.ListChilds {
                reportableTaxPayer?.chileRTP?.each { ReportableTaxPayer childRtpInstance ->
                    ChildRTP {
                        produceXMLForReportableTaxPaymentNode(reportableTaxPaymentXml, childRtpInstance)
                    }
                }
            }
        }
        return reportableTaxPaymentXml
    }
}
