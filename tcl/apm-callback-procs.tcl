ad_library {
    Procedures for initializing service contracts etc. for the
    evaluation portlet package. Should only be executed 
    once upon installation.
    
    @creation-date May 2004
    @author jopez@galileo.edu
    @cvs-id $Id$

}

namespace eval evaluation_portlet {}
namespace eval evaluation_assignments_portlet {}
namespace eval evaluation_evaluations_portlet {}
namespace eval evaluation_admin_portlet {}

ad_proc -public evaluation_portlet::after_install {} {
    Create the datasources needed by the evaluation portlets.
} {
        evaluation_assignments_portlet::after_install
        evaluation_evaluations_portlet::after_install
        evaluation_admin_portlet::after_install
}

ad_proc -public evaluation_portlet::before_uninstall {} {
    Evaluation Portlet package uninstall proc
} {

    db_transaction {
        evaluation_assignments_portlet::uninstall
        evaluation_evaluations_portlet::uninstall
        evaluation_admin_portlet::uninstall
    }
}


