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

ad_proc -private evaluation_portlet::after_install {} {
    Create the datasources needed by the evaluation portlets.
} {
        evaluation_assignments_portlet::after_install
        evaluation_evaluations_portlet::after_install
        evaluation_admin_portlet::after_install
}

ad_proc -private evaluation_assignments_portlet::after_install {} {
    Create the datasources needed by the evaluation assignments portlet.
} {
    
    db_transaction {
	set ds_id [portal::datasource::new \
                   -name "evaluation_assignments_portlet" \
                   -description "Evaluation Assignments Portlet"]

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



ad_proc -private evaluation_assignments_portlet::register_portal_datasource_impl {} {
    Create the service contracts needed by the evaluation assignments portlet.
} {
    set spec {
        name "evaluation_assignments_portlet"
	contract_name "portal_datasource"
	owner "evaluation-portlet"
        aliases {
	    GetMyName evaluation_assignments_portlet::get_my_name
	    GetPrettyName  evaluation_assignments_portlet::get_pretty_name
	    Link evaluation_assignments_portlet::link
	    AddSelfToPage evaluation_assignments_portlet::add_self_to_page
	    Show evaluation_assignments_portlet::show
	    Edit evaluation_assignments_portlet::edit
	    RemoveSelfFromPage evaluation_assignments_portlet::remove_self_from_page
        }
    }
    
    acs_sc::impl::new_from_spec -spec $spec
}


ad_proc -private evaluation_evaluations_portlet::after_install {} {
    Create the datasources needed by the evaluation evaluations portlet.
} {
    
    db_transaction {
	set ds_id [portal::datasource::new \
                   -name "evaluation_evaluations_portlet" \
                   -description "Evaluation Evaluations Portlet"]

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



ad_proc -private evaluation_evaluations_portlet::register_portal_datasource_impl {} {
    Create the service contracts needed by the evaluation evaluations portlet.
} {
    set spec {
        name "evaluation_evaluations_portlet"
	contract_name "portal_datasource"
	owner "evaluation-portlet"
        aliases {
	    GetMyName evaluation_evaluations_portlet::get_my_name
	    GetPrettyName  evaluation_evaluations_portlet::get_pretty_name
	    Link evaluation_evaluations_portlet::link
	    AddSelfToPage evaluation_evaluations_portlet::add_self_to_page
	    Show evaluation_evaluations_portlet::show
	    Edit evaluation_evaluations_portlet::edit
	    RemoveSelfFromPage evaluation_evaluations_portlet::remove_self_from_page
        }
    }
    
    acs_sc::impl::new_from_spec -spec $spec
}


ad_proc -private evaluation_admin_portlet::after_install {} {
    Create the datasources needed by the evaluation portlet.
} {
    
    ns_log Notice "SE meteeeeeeeeeeeeeee\n"
    db_transaction {
	set ds_id [portal::datasource::new \
                   -name "evaluation_admin_portlet" \
                   -description "Evaluation Admin Portlet"]

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



ad_proc -private evaluation_admin_portlet::register_portal_datasource_impl {} {
    Create the service contracts needed by the evaluation admin portlet.
} {
    set spec {
        name "evaluation_admin_portlet"
	contract_name "portal_datasource"
	owner "evaluation-portlet"
        aliases {
	    GetMyName evaluation_admin_portlet::get_my_name
	    GetPrettyName  evaluation_admin_portlet::get_pretty_name
	    Link evaluation_admin_portlet::link
	    AddSelfToPage evaluation_admin_portlet::add_self_to_page
	    Show evaluation_admin_portlet::show
	    Edit evaluation_admin_portlet::edit
	    RemoveSelfFromPage evaluation_admin_portlet::remove_self_from_page
        }
    }
    
    acs_sc::impl::new_from_spec -spec $spec
}


ad_proc -private evaluation_portlet::before_uninstall {} {
    Evaluation Portlet package uninstall proc
} {

    db_transaction {
        evaluation_assignments_portlet::uninstall
        evaluation_evaluations_portlet::uninstall
        evaluation_admin_portlet::uninstall
    }
}


ad_proc -private evaluation_assignments_portlet::uninstall {} {
    Evaluation Portlet package uninstall proc
} {
    unregister_implementations
}

ad_proc -private evaluation_evaluations_portlet::uninstall {} {
    Evaluation Portlet package uninstall proc
} {
    unregister_implementations
}

ad_proc -private evaluation_admin_portlet::uninstall {} {
    Evaluation Portlet package uninstall proc
} {
    unregister_implementations
}



ad_proc -private evaluation_assignments_portlet::unregister_implementations {} {
    Unregister service contract implementations
} {
    acs_sc::impl::delete \
        -contract_name "portal_datasource" \
        -impl_name "evaluation_assignments_portlet"
}

ad_proc -private evaluation_evaluations_portlet::unregister_implementations {} {
    Unregister service contract implementations
} {
    acs_sc::impl::delete \
        -contract_name "portal_datasource" \
        -impl_name "evaluation_evaluations_portlet"
}

ad_proc -private evaluation_admin_portlet::unregister_implementations {} {
    Unregister service contract implementations
} {
    acs_sc::impl::delete \
        -contract_name "portal_datasource" \
        -impl_name "evaluation_admin_portlet"
}
