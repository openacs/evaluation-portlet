ad_library {
    Automated tests.

    @author Mounir Lallali
    @creation-date 25 September  2005

}

aa_register_case -procs {
    evaluation_admin_portlet::show
    evaluation_assignments_portlet::show
    evaluation_evaluations_portlet::show
} -cats {
    api
    smoke
} evaluation_render_portlet {
    Test the rendering of the portlets
} {
    aa_run_with_teardown -rollback -test_code {
        set package_id [site_node::instantiate_and_mount \
                            -package_key evaluation \
                            -node_name __test_evaluation_portlet]

        foreach shaded_p {true false} {

            set cf [list \
                        package_id $package_id \
                        shaded_p $shaded_p \
                       ]

            foreach portlet {
                evaluation_admin_portlet evaluation_assignments_portlet evaluation_evaluations_portlet
            } {
                set section_name $portlet
                if {$shaded_p} {
                    append section_name " (shaded)"
                }
                aa_section $section_name

                set portlet [acs_sc::invoke \
                                 -contract portal_datasource \
                                 -operation Show \
                                 -impl $portlet \
                                 -call_args [list $cf]]

                aa_log "Portlet returns: [ns_quotehtml $portlet]"

                aa_false "No error was returned" {
                    [string first "Error in include template" $portlet] >= 0
                }

                aa_true "Portlet contains something" {
                    [string length [string trim $portlet]] > 0
                }
            }
        }
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_add_task {

    Test Add a Task to GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new task to GradeBook
        set task_name [ad_generate_random_string]
        set associated_file_name [evaluation::twt::create_file [ad_generate_random_string]]
        set task_description [ad_generate_random_string]
        set response [evaluation::twt::add_task $class_material_url $task_name $task_description $associated_file_name]
        aa_display_result -response $response -explanation {for additing a new Task to GradeBook}

        evaluation::twt::delete_file $associated_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_upload_task_solution {

    Test Upload a Task Solution in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new task to GradeBook
        set task_name [ad_generate_random_string]
        set task_description [ad_generate_random_string]
        set associated_file_name [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::add_task $class_material_url $task_name $task_description $associated_file_name

        # Upload a task solution to GradeBook
        set uploaded_file_name [evaluation::twt::create_file [ad_generate_random_string]]
        set response [evaluation::twt::upload_task_solution $class_material_url $task_name $uploaded_file_name]
        aa_display_result -response $response -explanation {for uploading task solution in GradeBook}

        evaluation::twt::delete_file $associated_file_name
        evaluation::twt::delete_file $uploaded_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_view_task_solution {

    Test View a Task Solution in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new task to GradeBook
        set task_name [ad_generate_random_string]
        set task_description [ad_generate_random_string]
        set associated_file_name [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::add_task $class_material_url $task_name $task_description $associated_file_name

        # Upload a task solution to GradeBook
        set uploaded_file_name [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::upload_task_solution $class_material_url $task_name $uploaded_file_name

        # View a task solution in GradeBook
        set response [evaluation::twt::view_task_solution $class_material_url $task_name $uploaded_file_name]
        aa_display_result -response $response -explanation {for viewing task solution in GradeBook}

        evaluation::twt::delete_file $associated_file_name
        evaluation::twt::delete_file $uploaded_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_edit_task_solution {

    Test Edit a Task Solution in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new task to GradeBook
        set task_name [ad_generate_random_string]
        set task_description [ad_generate_random_string]
        set associated_file_name [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::add_task $class_material_url $task_name $task_description $associated_file_name

        # Upload a task solution to GradeBook
        set uploaded_file_name [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::upload_task_solution $class_material_url $task_name $uploaded_file_name

        # Edit a task solution in GradeBook
        set new_uploaded_file_name [evaluation::twt::create_file [ad_generate_random_string]]
        set response [evaluation::twt::edit_task_solution $class_material_url $task_name $new_uploaded_file_name]
        aa_display_result -response $response -explanation {for editing task solution in GradeBook}

        evaluation::twt::delete_file $associated_file_name
        evaluation::twt::delete_file $uploaded_file_name
        evaluation::twt::delete_file $new_uploaded_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_view_task {

    Test View a Task in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new task to GradeBook
        set task_name [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set task_description [ad_generate_random_string]
        evaluation::twt::add_task $class_material_url $task_name $task_description $associated_file_name

        # view a task in GradeBook
        set response [evaluation::twt::view_task $class_material_url $task_name $task_description $associated_file_name]
        aa_display_result -response $response -explanation {for viewing a Task in GradeBook}

        evaluation::twt::delete_file $associated_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_edit_task {

    Test Edit a Task in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new task to GradeBook
        set task_name [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set task_description [ad_generate_random_string]
        evaluation::twt::add_task $class_material_url $task_name $task_description $associated_file_name

        # edit a task in GradeBook
        set new_task_name [ad_generate_random_string]
        set new_associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set new_task_description [ad_generate_random_string]
        set response [evaluation::twt::edit_task $class_material_url $task_name $new_task_name $new_task_description $new_associated_file_name ]
        aa_display_result -response $response -explanation {for editing a Task in GradeBook}

        evaluation::twt::delete_file $associated_file_name
        evaluation::twt::delete_file $new_associated_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_delete_task {

    Test delete a Task in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new task to GradeBook
        set task_name [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set task_description [ad_generate_random_string]
        evaluation::twt::add_task $class_material_url $task_name $task_description $associated_file_name

        # delete a task in GradeBook
        set response [evaluation::twt::delete_task $class_material_url $task_name]
        aa_display_result -response $response -explanation {for deleting a Task in GradeBook}

        evaluation::twt::delete_file $associated_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_add_project {

    Test Add a Project to GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new projet to GradeBook
        set project_name [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set project_description [ad_generate_random_string]

        set response [evaluation::twt::add_project $class_material_url $project_name $project_description $associated_file_name]
        aa_display_result -response $response -explanation {for additing a new Project to GradeBook}

        evaluation::twt::delete_file $associated_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_upload_project_solution {

    Test Upload a Project Solution in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new project to GradeBook
        set project_name [ad_generate_random_string]
        set project_description [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::add_project $class_material_url $project_name $project_description $associated_file_name

        # Upload a project  solution to GradeBook
        set uploaded_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set response [evaluation::twt::upload_project_solution $class_material_url $project_name $uploaded_file_name]
        aa_display_result -response $response -explanation {for uploading project solution in GradeBook}

        evaluation::twt::delete_file $associated_file_name
        evaluation::twt::delete_file $uploaded_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_view_project_solution {

    Test View a Project Solution in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new project to GradeBook
        set project_name [ad_generate_random_string]
        set project_description [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::add_project $class_material_url $project_name $project_description $associated_file_name

        # Upload a project solution to GradeBook
        set uploaded_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::upload_project_solution $class_material_url $project_name $uploaded_file_name

        # View a project solution in GradeBook
        set response [evaluation::twt::view_project_solution $class_material_url $project_name $uploaded_file_name]
        aa_display_result -response $response -explanation {for viewing project solution in GradeBook}

        evaluation::twt::delete_file $associated_file_name
        evaluation::twt::delete_file $uploaded_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_edit_project_solution {

    Test Edit a Project Solution in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new project to GradeBook
        set project_name [ad_generate_random_string]
        set project_description [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::add_project $class_material_url $project_name $project_description $associated_file_name

        # Upload a project solution to GradeBook
        set uploaded_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::upload_project_solution $class_material_url $project_name $uploaded_file_name

        # Edit a project solution in GradeBook
        set new_uploaded_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set response [evaluation::twt::edit_project_solution $class_material_url $project_name $new_uploaded_file_name]
        aa_display_result -response $response -explanation {for editing project solution in GradeBook}

        evaluation::twt::delete_file $associated_file_name
        evaluation::twt::delete_file $uploaded_file_name
        evaluation::twt::delete_file $new_uploaded_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_view_project {

    Test View a Project in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new project to GradeBook
        set project_name [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set project_description [ad_generate_random_string]
        evaluation::twt::add_project $class_material_url $project_name $project_description $associated_file_name

        # view a project in GradeBook
        set response [evaluation::twt::view_project $class_material_url $project_name $project_description $associated_file_name]
        aa_display_result -response $response -explanation {for viewing a Project in GradeBook}

        evaluation::twt::delete_file $associated_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_edit_project {

    Test Edit a Project in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new project to GradeBook
        set project_name [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set project_description [ad_generate_random_string]
        evaluation::twt::add_project $class_material_url $project_name $project_description $associated_file_name

        # edit a peoject in GradeBook
        set new_project_name [ad_generate_random_string]
        set new_associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set new_project_description [ad_generate_random_string]
        set response [evaluation::twt::edit_project $class_material_url $project_name $new_project_name $new_project_description $new_associated_file_name ]
        aa_display_result -response $response -explanation {for editing a Project in GradeBook}

        evaluation::twt::delete_file $associated_file_name
        evaluation::twt::delete_file $new_associated_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_delete_project {

    Test delete a Project in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new project to GradeBook
        set project_name [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set project_description [ad_generate_random_string]
        evaluation::twt::add_project $class_material_url $project_name $project_description $associated_file_name

        # delete a project in GradeBook
        set response [evaluation::twt::delete_project $class_material_url $project_name]
        aa_display_result -response $response -explanation {for deleting a Project in GradeBook}

        evaluation::twt::delete_file $associated_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_add_exam {

    Test Add an Exam to GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new exam to GradeBook
        set exam_name [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set exam_description [ad_generate_random_string]

        set response [evaluation::twt::add_exam $class_material_url $exam_name $exam_description $associated_file_name]
        aa_display_result -response $response -explanation {for additing a new Exam to GradeBook}

        evaluation::twt::delete_file $associated_file_name

        twt::user::logout
    }
}


aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_upload_exam_solution {

    Test Upload an Exam Solution in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new exam to GradeBook
        set exam_name [ad_generate_random_string]
        set exam_description [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::add_exam $class_material_url $exam_name $exam_description $associated_file_name

        # Upload a exam solution to GradeBook
        set uploaded_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set response [evaluation::twt::upload_exam_solution $class_material_url $exam_name $uploaded_file_name]
        aa_display_result -response $response -explanation {for uploading an exam solution in GradeBook}

        evaluation::twt::delete_file $associated_file_name
        evaluation::twt::delete_file $uploaded_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_view_exam_solution {

    Test View an Exam Solution in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new exam to GradeBook
        set exam_name [ad_generate_random_string]
        set exam_description [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::add_exam $class_material_url $exam_name $exam_description $associated_file_name

        # Upload a task solution to GradeBook
        set uploaded_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::upload_exam_solution $class_material_url $exam_name $uploaded_file_name

        # View a exam solution in GradeBook
        set response [evaluation::twt::view_exam_solution $class_material_url $exam_name $uploaded_file_name]
        aa_display_result -response $response -explanation {for viewing an exam solution in GradeBook}

        evaluation::twt::delete_file $associated_file_name
        evaluation::twt::delete_file $uploaded_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_edit_exam_solution {

    Test Edit an Exam Solution in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new exam to GradeBook
        set exam_name [ad_generate_random_string]
        set exam_description [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::add_exam $class_material_url $exam_name $exam_description $associated_file_name

        # Upload an exam solution to GradeBook
        set uploaded_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        evaluation::twt::upload_exam_solution $class_material_url $exam_name $uploaded_file_name

        # Edit an exam solution in GradeBook
        set new_uploaded_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set response [evaluation::twt::edit_exam_solution $class_material_url $exam_name $new_uploaded_file_name]
        aa_display_result -response $response -explanation {for editing an exam solution in GradeBook}

        evaluation::twt::delete_file $associated_file_name
        evaluation::twt::delete_file $uploaded_file_name
        evaluation::twt::delete_file $new_uploaded_file_name

        twt::user::logout
    }
}


aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_view_exam {

    Test View an Exam in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new exam to GradeBook
        set exam_name [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set exam_description [ad_generate_random_string]
        evaluation::twt::add_exam $class_material_url $exam_name $exam_description $associated_file_name

        # view an examk in GradeBook
        set response [evaluation::twt::view_exam $class_material_url $exam_name $exam_description $associated_file_name]
        aa_display_result -response $response -explanation {for viewing an exam in GradeBook}

        evaluation::twt::delete_file $associated_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_edit_exam {

    Test Edit an Exam in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new exam to GradeBook
        set exam_name [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set exam_description [ad_generate_random_string]
        evaluation::twt::add_exam $class_material_url $exam_name $exam_description $associated_file_name

        # edit an exam in GradeBook
        set new_exam_name [ad_generate_random_string]
        set new_associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set new_exam_description [ad_generate_random_string]
        set response [evaluation::twt::edit_exam $class_material_url $exam_name $new_exam_name $new_exam_description $new_associated_file_name ]
        aa_display_result -response $response -explanation {for editing an Exam in GradeBook}

        evaluation::twt::delete_file $associated_file_name
        evaluation::twt::delete_file $new_associated_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_delete_exam {

    Test delete an Exam in GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Get the class material url
        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new exam to GradeBook
        set exam_name [ad_generate_random_string]
        set associated_file_name  [evaluation::twt::create_file [ad_generate_random_string]]
        set exam_description [ad_generate_random_string]
        evaluation::twt::add_exam $class_material_url $exam_name $exam_description $associated_file_name

        # delete an exam in GradeBook
        set response [evaluation::twt::delete_exam $class_material_url $exam_name]
        aa_display_result -response $response -explanation {for deleting an Exam in GradeBook}

        evaluation::twt::delete_file $associated_file_name

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_request_notification_GradeBook {

    Test Request Notification for GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Request a notification GradeBook
        set class_material_url [evaluation::twt::get_evaluation_url]
        set responses [evaluation::twt::request_notification_GradeBook $class_material_url]
        aa_display_result -response [lindex $responses 3] -explanation {for requesting a notification GradeBook}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_request_notification_Evaluation {

    Test Request Notification for Evaluation.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        set class_material_url [evaluation::twt::get_evaluation_url]
        set responses [evaluation::twt::request_notification_Evaluation $class_material_url]
        aa_display_result -response [lindex $responses 3] -explanation {for requesting a notification Evaluation}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_unsubscribe_GradeBook {

    Test Unsubscribe of GradeBook.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Unsubscribe a notification GradeBook
        set class_material_url [evaluation::twt::get_evaluation_url]
        set list_ids [evaluation::twt::request_notification_GradeBook $class_material_url]

        set response [evaluation::twt::unsubscribe_GradeBook $class_material_url [lindex $list_ids 0] [lindex $list_ids 1] [lindex $list_ids 2]]
        aa_display_result -response $response -explanation {unsubscribing a notification GradeBook}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_unsubscribe_Evaluation {

    Test Unsubscribe of Evaluation.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        # Unsubscribing a notification Evaluation
        set class_material_url [evaluation::twt::get_evaluation_url]
        set list_ids [evaluation::twt::request_notification_Evaluation $class_material_url]

        set response [evaluation::twt::unsubscribe_Evaluation $class_material_url [lindex $list_ids 0] [lindex $list_ids 1] [lindex $list_ids 2]]
        aa_display_result -response $response -explanation {unsubscribing a notification Evaluation}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_add_assignment_type {

    Test Add a new Assignment Type.

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear

        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        set class_material_url [evaluation::twt::get_evaluation_url]

        # Add a new assignment type
        set assigment_type_name  [ad_generate_random_string]
        set response [evaluation::twt::add_assignment_type $class_material_url $assigment_type_name]
        aa_display_result -response $response -explanation {additing a new assignment type}

        twt::user::logout
    }
}

aa_register_case -procs {
        evaluation_admin_portlet::link
        evaluation_evaluations_portlet::link
        evaluation_assignments_portlet::link
        evaluation_admin_portlet::get_pretty_name
        evaluation_assignments_portlet::get_pretty_name
        evaluation_evaluations_portlet::get_pretty_name
    } -cats {
        api
        production_safe
    } evaluation_portlet_links_names {
        Test diverse link and name procs.
} {
    aa_equals "Evaluation admin portlet link"               "[evaluation_admin_portlet::link]" ""
    aa_equals "Evaluation evaluations portlet link"         "[evaluation_evaluations_portlet::link]" ""
    aa_equals "Evaluation assignments portlet link"         "[evaluation_assignments_portlet::link]" ""
    aa_equals "Evaluation admin portlet pretty name"        "[evaluation_admin_portlet::get_pretty_name]" "#evaluation-portlet.lt_Evaluation_Administra#"
    aa_equals "Evaluation evaluations portlet pretty name"  "[evaluation_evaluations_portlet::get_pretty_name]" "#evaluation-portlet.Evaluations_#"
    aa_equals "Evaluation assignments portlet pretty name"  "[evaluation_assignments_portlet::get_pretty_name]" "#evaluation-portlet.Assignments#"
}

aa_register_case -procs {
        evaluation_evaluations_portlet::add_self_to_page
        evaluation_evaluations_portlet::remove_self_from_page
        evaluation_assignments_portlet::add_self_to_page
        evaluation_assignments_portlet::remove_self_from_page
        evaluation_admin_portlet::add_self_to_page
        evaluation_admin_portlet::remove_self_from_page
    } -cats {
        api
    } evaluation_portlet_add_remove_from_page {
        Test add/remove portlet procs.
} {
    #
    # Helper proc to check portal elements
    #
    proc portlet_exists_p {portal_id portlet_name} {
        return [db_0or1row portlet_in_portal {
            select 1 from dual where exists (
              select 1
                from portal_element_map pem,
                     portal_pages pp
               where pp.portal_id = :portal_id
                 and pp.page_id = pem.page_id
                 and pem.name = :portlet_name
            )
        }]
    }
    #
    # Start the tests
    #
    aa_run_with_teardown -rollback -test_code {
        #
        # Create a community.
        #
        # As this is running in a transaction, it should be cleaned up
        # automatically.
        #
        set community_id [dotlrn_community::new -community_type dotlrn_community -pretty_name foo]
        if {$community_id ne ""} {
            aa_log "Community created: $community_id"
            set portal_id [dotlrn_community::get_admin_portal_id -community_id $community_id]
            set package_id [dotlrn::instantiate_and_mount $community_id [evaluation_evaluations_portlet::my_package_key]]
            #
            # evaluation_evaluations_portlet
            #
            set portlet_name [evaluation_evaluations_portlet::get_my_name]
            #
            # Add portlet.
            #
            evaluation_evaluations_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id -param_action ""
            aa_true "Evaluations portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Remove portlet.
            #
            evaluation_evaluations_portlet::remove_self_from_page -portal_id $portal_id -package_id $package_id
            aa_false "Evaluations portlet is in community portal after removal" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            evaluation_evaluations_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id -param_action ""
            aa_true "Evaluations portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # assignments_portlet
            #
            set portlet_name [evaluation_assignments_portlet::get_my_name]
            #
            # Add portlet.
            #
            evaluation_assignments_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id -param_action ""
            aa_true "Assignments portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Remove portlet.
            #
            evaluation_assignments_portlet::remove_self_from_page -portal_id $portal_id -package_id $package_id
            aa_false "Assignments portlet is in community portal after removal" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            evaluation_assignments_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id -param_action ""
            aa_true "Assignments portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # admin_portlet
            #
            set portlet_name [evaluation_admin_portlet::get_my_name]
            #
            # Add portlet.
            #
            evaluation_admin_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id
            aa_true "Admin portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Remove portlet.
            #
            evaluation_admin_portlet::remove_self_from_page -portal_id $portal_id
            aa_false "Admin portlet is in community portal after removal" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            evaluation_admin_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id
            aa_true "Admin portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
        } else {
            aa_error "Community creation failed"
        }
    }
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
