ad_page_contract {

	evaluations chunk to be displayed in the index page

}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]
set admin_p [permission::permission_p -party_id $user_id -object_id $package_id -privilege admin]

set base_url [ad_conn package_url]

db_1row get_grade_info { *SQL* }

set elements [list task_name \
		  [list label "[_ evaluation-portlet.Name_]" \
		       link_url_col task_url \
		       orderby_asc {task_name asc} \
		       orderby_desc {task_name desc}] \
		 ]
if { $admin_p } { 
	#admin
	lappend elements task_weight \
		[list label "[_ evaluation-portlet.Weight_]" \
			 display_template { <center>@grade_tasks_admin.task_weight@%</center> } \
			 orderby_asc {task_weight asc} \
			 orderby_desc {task_weight desc}] 
	set multirow_name grade_tasks_admin
	set actions [list "[_ evaluation-portlet.lt_Edit_grades_distribut]" [export_vars -base "${base_url}evaluation/admin/grades/distribution-edit" { grade_id }]]
} else { 
	#student
	lappend elements grade \
		[list label "[_ evaluation-portlet.Grade_over_100_]" \
			 display_template { <center>@grade_tasks.grade@</center> } \
			 orderby_asc {grade asc} \
			 orderby_desc {grade desc}] 
	lappend elements comments \
		[list label "[_ evaluation-portlet.Comments_]" \
			 link_url_col comments_url \
			 link_html { title "[_ evaluation-portlet.lt_View_evaluation_comme]" }]
	lappend elements task_weight \
		[list label "[_ evaluation-portlet.Net_Value_]" \
			 display_template { <center>@grade_tasks.task_weight@</center> } \
			 orderby_asc {task_weight asc} \
			 orderby_desc {task_weight desc}] 
	lappend elements answer \
		[list label "" \
			 link_url_col answer_url \
			 link_html { title "[_ evaluation-portlet.View_my_answer_]" }]
	set multirow_name grade_tasks
	set actions ""
}

set total_grade 0.00
set max_grade 0.00
set category_weight 0

template::list::create \
    -name grade_tasks \
    -multirow $multirow_name \
    -actions $actions \
    -key task_id \
    -pass_properties { return_url mode base_url } \
    -filters { grade_id } \
    -elements $elements \
    -orderby_name evaluations_orderby \
    -orderby { default_value task_name }
	
set evaluations_orderby [template::list::orderby_clause -orderby -name grade_tasks]
	
if { [string equal $evaluations_orderby ""] } {
	set evaluations_orderby " order by task_name asc"
}

if { $admin_p } { 
	#admin
    db_multirow -extend { task_url } grade_tasks_admin get_tasks_admin { *SQL* } {
	set task_url [export_vars -base "${base_url}evaluation/admin/evaluations/student-list" { task_id grade_id }]
	set category_weight [expr $category_weight + $task_weight]
	set task_weight [format %.2f [lc_numeric $task_weight]]
    }
} else {

    db_multirow -extend { comments comments_url answer answer_url } grade_tasks get_grade_tasks { *SQL* } {
	
	if { ![empty_string_p $comments] } {
	    set comments "[_ evaluation-portlet.View_comments_]"
	    set comments_url evaluation_view
	}
	
	set over_weight ""
	if { ![empty_string_p $show_student_p] && $show_student_p } {
	    
	    if { ![empty_string_p $grade] } {
		set grade [format %.2f [lc_numeric $grade]]
		set over_weight "[format %.2f [lc_numeric $task_grade]]/"
		set total_grade [expr $total_grade + $task_grade] 
	    } else {
		set grade "[_ evaluation-portlet.Not_evaluated_]"
	    }
	    
	    set max_grade [expr $task_weight + $max_grade] 
	    set task_weight "${over_weight}[format %.2f [lc_numeric $task_weight]]"
	    
	} else {
	    set grade "[_ evaluation-portlet.Not_available_]"
	    set task_weight "[_ evaluation-portlet.Not_available_]"
	}
	
	# working with answer stuff (if it has a file/url attached)
	if { [empty_string_p $answer_data] } {
	    set answer_url ""
	    set answer ""
	} elseif { [regexp "http://" $answer_data] } {
	    set answer_url "[export_vars -base "$answer_data" { }]"
	    set answer "[_ evaluation-portlet.View_my_answer_]"
	} else {
	    # we assume it's a file
	    set answer_url "[export_vars -base "${base_url}evaluation/view/$answer_title" { {revision_id $answer_id} }]"
	    set answer "[_ evaluation-portlet.View_my_answer_]"
	}
	
	if { $number_of_members > 1 && [string eq [db_string get_group_id { *SQL* }] 0] } {
	    set answer ""
	    set answer_url ""
	    set grade "[_ evaluation-portlet.No_group_for_task_]"
	}
	
    } 
}

if { $admin_p } {
    set bottom_line "[_ evaluation-portlet.lt_smallWeight_used_in_g]"
} else {
    set bottom_line "[_ evaluation-portlet.lt_smallTotal_points_in__1]"
}
