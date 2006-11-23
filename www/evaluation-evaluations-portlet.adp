
  <if @shaded_p@ ne "t">
   <ul>
   <if @admin_p@ eq 1>
   <if @simple_p@ eq 1>
     <li class="arrow"><a href="evaluation/admin/grades/grades" title="#evaluation-portlet.lt_Admin_my_Asignment_T#"><text class="blue"><b>#evaluation-portlet.lt_Admin_my_Assignment_T#</b></text></a><br>
	<text class="blue">#evaluation-portlet.admin_help#</text></li>
      <li class="arrow"><a href="evaluation/admin/grades/grades-reports" title="#evaluation-portlet.view_students_grades#"><text class="blue"><b>#evaluation-portlet.view_students_grades#</b></text></a><br>
	<text class="blue">#evaluation-portlet.view_grades_help#</text></li>
      <li class="arrow"><text class="blue"><b>Notifications</b>
   </if>
  <else>
      <li><a href="evaluation/admin/grades/grades" title="#evaluation-portlet.lt_Admin_my_Assignment_T#">#evaluation-portlet.lt_Admin_my_Assignment_T#</a><br /></li>
  </else>  
   </if>
  <if @simple_p@ eq 1>
  <br>@notification_chunk;noquote@
  <br>
  <br>
  
 </if> <else>
   <li>  @notification_chunk;noquote@</li>
 </else>
</ul>
<ul>
    <if @grades:rowcount@ eq 0>
	
       <li>#evaluation-portlet.lt_There_are_no_tasks_to#</li>
	
    </if><else>
    <multiple name="grades">
     <if @simple_p@ eq 0>
       <li><strong>@grades.grade_plural_name;noquote@</strong> </li>
     </if> 
     
      <include src="../lib/evaluations-chunk" grade_id=@grades.grade_id@ grade_item_id=@grades.grade_item_id@ evaluations_orderby=@evaluations_orderby@ page_num=@page_num@>
       <br /><br />
       </li>
    </multiple>
    <if @admin_p@ eq "0" and @one_instance_p@ eq "1">
     <br />#evaluation-portlet.lt_Your_total_grade_in_t# <strong>@total_class_grade@/@max_possible_grade@ </strong>
    </if>
    </else>
   </ul>
  </if>
  <else>
  &nbsp;
  </else>


