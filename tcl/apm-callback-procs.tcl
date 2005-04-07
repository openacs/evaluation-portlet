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


ad_proc -private evaluation_assignments_portlet::after_install {} {
    Create the datasources needed by the evaluation assignments portlet.
} {
    
    db_transaction {
	set ds_id [portal::datasource::new \
                   -name "evaluation_assignments_portlet" \
                   -description "[_ evaluation-portlet.lt_Evaluation_Assignment]"]

	portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shadeable_p \
            -value t

	portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key hideable_p \
            -value t

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key user_editable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shaded_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key link_hideable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p f \
            -key package_id \
            -value ""

	register_portal_datasource_impl

    }
}

ad_proc -private evaluation_evaluations_portlet::after_install {} {
    Create the datasources needed by the evaluation evaluations portlet.
} {
    
    db_transaction {
	set ds_id [portal::datasource::new \
                   -name "evaluation_evaluations_portlet" \
                   -description "[_ evaluation-portlet.lt_Evaluation_Evaluation]"]

	portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shadeable_p \
            -value t

	portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key hideable_p \
            -value t

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key user_editable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shaded_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key link_hideable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p f \
            -key package_id \
            -value ""

	register_portal_datasource_impl

    }
}

ad_proc -private evaluation_admin_portlet::after_install {} {
    Create the datasources needed by the evaluation portlet.
} {
    
    db_transaction {
	set ds_id [portal::datasource::new \
                   -name "evaluation_admin_portlet" \
                   -description "[_ evaluation-portlet.lt_Evaluation_Admin_Port]"]

	portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shadeable_p \
            -value f

	portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key hideable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key user_editable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shaded_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key link_hideable_p \
            -value t

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p f \
            -key package_id \
            -value ""

	register_portal_datasource_impl
    }
}


