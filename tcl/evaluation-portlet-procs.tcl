ad_library {

    Procedures to support the evaluation portlets

    @creation-date May 2004
    @author jopez@galileo.edu
    @cvs_id $Id$

}

namespace eval evaluation_assignments_portlet {}
namespace eval evaluation_evaluations_portlet {}
namespace eval evaluation_admin_portlet {}


#
# evaluation assignments namespace
#

ad_proc -private evaluation_assignments_portlet::get_my_name {
} {
    return "evaluation_assignments_portlet"
}



ad_proc -private evaluation_assignments_portlet::my_package_key {
} {
    return "evaluation-portlet"
}



ad_proc -public evaluation_assignments_portlet::get_pretty_name {
} {
    return "[_ evaluation-portlet.Assignments_]"
}



ad_proc -public evaluation_assignments_portlet::link {
} {
    return ""
}



ad_proc -public evaluation_assignments_portlet::add_self_to_page {
    {-portal_id:required}
    {-package_id:required}
    {-param_action:required}
    {-force_region ""}
    {-page_name "" }
} {
    Adds a evaluation PE to the given portal.
    
    @param portal_id The page to add self to
    @param package_id The community with the folder
    
    @return element_id The new element's id
} {
    return [portal::add_element_parameters \
                -portal_id $portal_id \
                -portlet_name [get_my_name] \
                -value $package_id \
                -force_region $force_region \
		-page_name $page_name \
                -pretty_name [get_pretty_name] \
                -param_action $param_action
           ]
}



ad_proc -public evaluation_assignments_portlet::remove_self_from_page {
    {-portal_id:required}
    {-package_id:required}
} {
    Removes a evaluation PE from the given page or the package_id of the
    evaluation package from the portlet if there are others remaining
    
    @param portal_id The page to remove self from
    @param package_id
} {
    portal::remove_element_parameters \
        -portal_id $portal_id \
        -portlet_name [get_my_name] \
        -value $package_id
}



ad_proc -public evaluation_assignments_portlet::show {
    cf
} {
    portal::show_proc_helper \
        -package_key [my_package_key] \
        -config_list $cf \
        -template_src "evaluation-assignments-portlet"
}


#
# evaluation evaluations namespace
#

ad_proc -private evaluation_evaluations_portlet::get_my_name {
} {
    return "evaluation_evaluations_portlet"
}



ad_proc -private evaluation_evaluations_portlet::my_package_key {
} {
    return "evaluation-portlet"
}



ad_proc -public evaluation_evaluations_portlet::get_pretty_name {
} {
    return "[_ evaluation-portlet.Evaluations_]"
}



ad_proc -public evaluation_evaluations_portlet::link {
} {
    return ""
}



ad_proc -public evaluation_evaluations_portlet::add_self_to_page {
    {-portal_id:required}
    {-package_id:required}
    {-param_action:required}
    {-force_region ""}
    {-page_name "" }
} {
    Adds a evaluation PE to the given portal.
    
    @param portal_id The page to add self to
    @param package_id The community with the folder
    
    @return element_id The new element's id
} {
    return [portal::add_element_parameters \
                -portal_id $portal_id \
                -portlet_name [get_my_name] \
                -value $package_id \
                -force_region $force_region \
		-page_name $page_name \
                -pretty_name [get_pretty_name] \
                -param_action $param_action
           ]
}



ad_proc -public evaluation_evaluations_portlet::remove_self_from_page {
    {-portal_id:required}
    {-package_id:required}
} {
    Removes a evaluation PE from the given page or the package_id of the
    evaluation package from the portlet if there are others remaining
    
    @param portal_id The page to remove self from
    @param package_id
} {
    portal::remove_element_parameters \
        -portal_id $portal_id \
        -portlet_name [get_my_name] \
        -value $package_id
}



ad_proc -public evaluation_evaluations_portlet::show {
    cf
} {
    portal::show_proc_helper \
        -package_key [my_package_key] \
        -config_list $cf \
        -template_src "evaluation-evaluations-portlet"
}

ad_proc -private evaluation_admin_portlet::get_my_name {} {
    return "evaluation_admin_portlet"
}


ad_proc -public evaluation_admin_portlet::get_pretty_name {} {
    return "[_ evaluation-portlet.lt_Evaluation_Administra]"
}



ad_proc -private evaluation_admin_portlet::my_package_key {} {
    return "evaluation-portlet"
}



ad_proc -public evaluation_admin_portlet::link {} {
    return ""
}



ad_proc -public evaluation_admin_portlet::add_self_to_page {
    {-portal_id:required}
    {-page_name ""}
    {-package_id:required}
} {
    Adds a evaluation admin PE to the given portal

    @param portal_id The page to add self to
    @param package_id The package_id of the evaluation package

    @return element_id The new element's id
} {
    return [portal::add_element_parameters \
                -portal_id $portal_id \
                -portlet_name [get_my_name] \
                -key package_id \
                -value $package_id
           ]
}



ad_proc -public evaluation_admin_portlet::remove_self_from_page {
    {-portal_id:required}
} {
    Removes a evaluation admin PE from the given page
} {
    portal::remove_element \
        -portal_id $portal_id \
        -portlet_name [get_my_name]
}



ad_proc -public evaluation_admin_portlet::show {
    cf
} {
} {
    portal::show_proc_helper \
        -package_key [my_package_key] \
        -config_list $cf \
        -template_src "evaluation-admin-portlet"

}



#
# evaluation assignments namespace
#

ad_proc -private evaluation_admin_portlet::get_my_name {} {
    return "evaluation_admin_portlet"
}


ad_proc -public evaluation_admin_portlet::get_pretty_name {} {
    return "[_ evaluation-portlet.lt_Evaluation_Administra]"
}



ad_proc -private evaluation_admin_portlet::my_package_key {} {
    return "evaluation-portlet"
}



ad_proc -public evaluation_admin_portlet::link {} {
    return ""
}



ad_proc -public evaluation_admin_portlet::add_self_to_page {
    {-portal_id:required}
    {-page_name ""}
    {-package_id:required}
} {
    Adds a evaluation admin PE to the given portal

    @param portal_id The page to add self to
    @param package_id The package_id of the evaluation package

    @return element_id The new element's id
} {
    return [portal::add_element_parameters \
                -portal_id $portal_id \
                -portlet_name [get_my_name] \
                -key package_id \
                -value $package_id
           ]
}



ad_proc -public evaluation_admin_portlet::remove_self_from_page {
    {-portal_id:required}
} {
    Removes a evaluation admin PE from the given page
} {
    portal::remove_element \
        -portal_id $portal_id \
        -portlet_name [get_my_name]
}



ad_proc -public evaluation_admin_portlet::show {
    cf
} {
} {
    portal::show_proc_helper \
        -package_key [my_package_key] \
        -config_list $cf \
        -template_src "evaluation-admin-portlet"

}
