
  <if @shaded_p@ ne "t">
   <ul>
    <if @admin_p@ eq 1>
     <if @simple_p@ eq 1>
      <li class="arrow"><a href="evaluation/admin/grades/grades" title="#evaluation-portlet.lt_Admin_my_Asignment_T#"><b>#evaluation-portlet.lt_Admin_my_Assignment_T#</b></a><br>
	#evaluation-portlet.admin_help#</li>
      <li class="arrow"><a href="evaluation/admin/grades/grades-reports" title="#evaluation-portlet.view_students_grades#"><b>#evaluation-portlet.view_students_grades#</b></a><br>
	#evaluation-portlet.view_grades_help#</li>
      <li class="arrow"><b>Notifications</b>
     </if>
     <else>
      <li><a href="evaluation/admin/grades/grades" title="#evaluation-portlet.lt_Admin_my_Assignment_T#">#evaluation-portlet.lt_Admin_my_Assignment_T#</a></li>
     </else>  
    </if>
    <if @simple_p@ eq 1>
     <br>@notification_chunk;noquote@</li>
    </if> 
    <else>
     <li>@notification_chunk;noquote@</li>
    </else>
   </ul>

    <if @grades:rowcount@ eq 0>
	
       <ul><li>#evaluation-portlet.lt_There_are_no_tasks_to#</li></ul>
	
    </if>
    <else>
     <ul>
      <multiple name="grades">
       <if @simple_p@ eq 0>
        <li><strong>@grades.grade_plural_name;noquote@</strong>
       </if> 
       <include src="../lib/evaluations-chunk" grade_id=@grades.grade_id@ grade_item_id=@grades.grade_item_id@ evaluations_orderby=@evaluations_orderby@ page_num=@page_num@>
       <br/><br/>
       <if @simple_p@ eq 0></li></if> 
      </multiple>
     </ul>

     <if @admin_p@ eq "0" and @one_instance_p@ eq "1">
      <p>#evaluation-portlet.lt_Your_total_grade_in_t# <strong>@total_class_grade@/@max_possible_grade@ </strong></p>
     </if>
    </else>

  </if>
  <else>
  &nbsp;
  </else>


